ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  class_attr_index = html_tag.index 'class="'

  if class_attr_index
    html_tag.insert class_attr_index + 7, 'border-red-500 '
  else
    html_tag.insert html_tag.index('>'), ' class="border-red-500"'
  end
end
