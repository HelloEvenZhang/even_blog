require 'will_paginate/view_helpers/link_renderer'
require 'will_paginate/view_helpers/action_view'

class TailwindcssPaginateRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    { class: "isolate inline-flex -space-x-px rounded-md shadow-sm", :"aria-label" => "Pagination" }
  end

  def html_container(html)
    tag(:nav, html, container_attributes)
  end

  def page_number(page)
    current_classname = "relative z-10 inline-flex items-center bg-primary-700 hover:bg-primary-800 px-4 py-2 text-sm font-semibold text-white focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sky-500 dark:focus-visible:outline-sky-600"
    classname = "relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset  focus:z-20 focus:outline-offset-0"
    if page == current_page
      tag(:em, page, :class => current_classname, :"aria-current" => 'page')
    else
      link(page, page, :class => classname, :rel => rel_value(page))
    end
  end

  def gap
    text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
    %(<span class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 ring-1 ring-inset focus:outline-offset-0">#{text}</span>)
  end

  def previous_page
    num = @collection.current_page > 1 && @collection.current_page - 1
    classname = "relative inline-flex items-center rounded-l-md px-2 py-2 text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset focus:z-20 focus:outline-offset-0"
    span = tag(:span, @options[:previous_label], :class => "sr-only")
    svg_path = tag(:path, nil, :"fill-rule" => "evenodd", :d => "M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z", :"clip-rule" => "evenodd")
    svg = tag(:svg, svg_path, :class => "h-5 w-5", :viewBox => "0 0 20 20", :fill => "currentColor", :"aria-hidden" => "true")
    previous_or_next_page(num, span + svg, classname)
  end
  
  def next_page
    num = @collection.current_page < total_pages && @collection.current_page + 1
    classname = "relative inline-flex items-center rounded-r-md px-2 py-2 text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset focus:z-20 focus:outline-offset-0"
    span = tag(:span, @options[:next_label], :class => "sr-only")
    svg_path = tag(:path, nil, :"fill-rule" => "evenodd", :d => "M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z", :"clip-rule" => "evenodd")
    svg = tag(:svg, svg_path, :class => "h-5 w-5", :viewBox => "0 0 20 20", :fill => "currentColor", :"aria-hidden" => "true")
    previous_or_next_page(num, span + svg, classname)
  end
  
  def previous_or_next_page(page, text, classname)
    if page
      link(text, page, :class => classname)
    else
      tag(:span, text, :class => classname)
    end
  end
end

# <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
# <a href="#" class="relative inline-flex items-center rounded-l-md px-2 py-2 text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset focus:z-20 focus:outline-offset-0">
#   <span class="sr-only">Previous</span>
#   <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
#     <path fill-rule="evenodd" d="M12.79 5.23a.75.75 0 01-.02 1.06L8.832 10l3.938 3.71a.75.75 0 11-1.04 1.08l-4.5-4.25a.75.75 0 010-1.08l4.5-4.25a.75.75 0 011.06.02z" clip-rule="evenodd" />
#   </svg>
# </a>
# <a href="#" aria-current="page" class="relative z-10 inline-flex items-center bg-sky-500 dark:bg-sky-600 px-4 py-2 text-sm font-semibold text-white dark:text-gray-100 focus:z-20 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-sky-500 dark:focus-visible:outline-sky-600">1</a>
# <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset  focus:z-20 focus:outline-offset-0">2</a>
# <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset  focus:z-20 focus:outline-offset-0">3</a>
# <span class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 ring-1 ring-inset focus:outline-offset-0">...</span>
# <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset  focus:z-20 focus:outline-offset-0">8</a>
# <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset  focus:z-20 focus:outline-offset-0">9</a>
# <a href="#" class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset  focus:z-20 focus:outline-offset-0">10</a>
# <a href="#" class="relative inline-flex items-center rounded-r-md px-2 py-2 text-slate-500 dark:text-slate-400 ring-slate-500 dark:ring-slate-400 hover:bg-gray-100 dark:hover:bg-gray-800 ring-1 ring-inset focus:z-20 focus:outline-offset-0">
#   <span class="sr-only">Next</span>
#   <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
#     <path fill-rule="evenodd" d="M7.21 14.77a.75.75 0 01.02-1.06L11.168 10 7.23 6.29a.75.75 0 111.04-1.08l4.5 4.25a.75.75 0 010 1.08l-4.5 4.25a.75.75 0 01-1.06-.02z" clip-rule="evenodd" />
#   </svg>
# </a>
# </nav>
