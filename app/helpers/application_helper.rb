module ApplicationHelper
  def sortable(column)
    title ||= column.titleize
    css_class = column == sort_column ? "current" : nil
    link_to title, {:sort => column}, {:class => css_class}
  end
end
