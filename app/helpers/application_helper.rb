module ApplicationHelper
  def will_paginate(coll_or_options = nil, options = {})
    if coll_or_options.is_a? Hash
      options = coll_or_options
      coll_or_options = nil
    end
    unless options[:renderer]
      options = options.merge renderer: TailwindcssPaginateRenderer
    end
    super *[coll_or_options, options].compact
  end

  def seo_title
    @seo_title.presence || "你好Even"
  end

  def seo_keywords
    @seo_keywords.presence || "你好Even, 博客, 技术, 生活"
  end

  def seo_description
    @seo_description.presence || "你好Even是一个用于分享技术与生活的博客"
  end
end
