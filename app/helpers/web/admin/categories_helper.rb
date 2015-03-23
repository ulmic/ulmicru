module Web::Admin::CategoriesHelper
  def get_categories_tree
    return if @categories_tree == [{}]
    (content_tag(:ul, class: '') do
      @categories_tree.each do |root|
        concat(content_tag(:li, class: '') do
          concat(get_categories_tree_by_category(root))
        end)
      end
    end)
  end

  def get_categories_tree_by_category(category)
    if category[:childs].present?
      concat link_to(category[:category_name], "#")
      concat content_tags_for_edit_category(category[:id])
      (content_tag(:ul, class: '') do
        category[:childs].each do |child|
          concat(content_tag(:li, class: '') do
            concat(get_categories_tree_by_category(child))
          end)
        end
      end)
    else
      concat link_to(category[:category_name], '#')
      content_tags_for_edit_category(category[:id])
    end
  end

  def content_tags_for_edit_category(href)
    tags = (link_to(new_admin_category_path(:id => href.to_s), class: 'btn btn-xs btn-success')do
      content_tag(:span, "", :class => "glyphicon glyphicon-plus")
    end)
    tags += (link_to(edit_admin_category_path(:id => href.to_s), class: 'btn btn-xs btn-warning')do
      content_tag(:span, "", :class => "glyphicon glyphicon-pencil")
    end)
    tags += (link_to(admin_category_path(Category.find(href.to_s)), method: :delete, class: 'btn btn-xs btn-danger') do
      content_tag(:span, "", :class => "glyphicon glyphicon-remove")
    end)
    return tags
  end
end
