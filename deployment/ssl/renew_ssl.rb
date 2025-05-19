require 'tencentcloud-sdk-ssl'
require 'zip'

include TencentCloud::Common

begin
  error_count = 0
  cred = Credential.new(ENV["TENCENTCLOUD_SECRET_ID"], ENV["TENCENTCLOUD_SECRET_KEY"])
  cli = TencentCloud::Ssl::V20191205::Client.new(cred, 'ap-guangzhou')

  # 申请证书
  apply_certificate_req = TencentCloud::Ssl::V20191205::ApplyCertificateRequest.new("DNS_AUTO","helloeven.com")
  apply_certificate_res = cli.ApplyCertificate(apply_certificate_req)
  certificate_id = apply_certificate_res.CertificateId


  # 检查证书域名验证是否通过
  verify_logic = Proc.new {
    check_certificate_dinaub_verification_req = TencentCloud::Ssl::V20191205::CheckCertificateDomainVerificationRequest.new(certificate_id)
    check_certificate_dinaub_verification_res = cli.CheckCertificateDomainVerification(check_certificate_dinaub_verification_req)
    check_certificate_dinaub_verification_res.VerificationResults.all? { |result| result.CaCheck > 0 }
  }

  # 不通过的时候主动触发证书验证
  while(!verify_logic.call) do
    error_count += 1
    raise TencentCloudSDKException.new(0, "Error time too much!!!") if error_count >= 20

    complete_certificate_req = TencentCloud::Ssl::V20191205::CompleteCertificateRequest.new(certificate_id)
    complete_certificate_res = cli.CompleteCertificate(complete_certificate_req)
    sleep(5)
  end

  # 下载证书并替换当前证书
  # 1. 解码 base64 并写入临时 zip 文件
  download_certificate_req = TencentCloud::Ssl::V20191205::DownloadCertificateRequest.new(certificate_id)
  download_certificate_res = cli.DownloadCertificate(download_certificate_req)

  zip_path = '/tmp/certificate.zip'
  File.open(zip_path, 'wb') do |f|
    f.write(Base64.decode64(download_certificate_res.Content))
  end

  # 2. 解压缩 ZIP 文件到临时目录
  extract_path = '/tmp/certificate_extract'
  FileUtils.rm_rf(extract_path)
  FileUtils.mkdir_p(extract_path)

  Zip::File.open(zip_path) do |zip_file|
    zip_file.each do |entry|
      entry.extract(File.join(extract_path, entry.name))
    end
  end

  # 3. 查找 .crt 和 .key 文件
  crt_file = Dir[File.join(extract_path, 'Nginx', '*.crt')].first
  key_file = Dir[File.join(extract_path, 'Nginx', '*.key')].first

  raise TencentCloudSDKException.new(0, "找不到 .crt 文件") unless crt_file
  raise TencentCloudSDKException.new(0, "找不到 .key 文件") unless key_file

  # 4. 拷贝到 /certs（覆盖）
  target_dir = '/certs'
  FileUtils.cp(crt_file, File.join(target_dir, 'helloeven.com_bundle.crt'))
  FileUtils.cp(key_file, File.join(target_dir, 'helloeven.com.key'))

  puts "证书已成功更新到 /certs"

rescue TencentCloudSDKException => e
  puts e.message
  puts e.backtrace.inspect
end