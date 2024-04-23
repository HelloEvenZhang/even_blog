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
end
