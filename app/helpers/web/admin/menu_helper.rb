module Web::Admin::MenuHelper
  def menu_item_collection
    [ :event, :news, { people: [ :questionary ] }, activity: [ :letter, 'activity_lines/lider/ya_lider' ], content: [ :place ]]
  end

  def model_icon(model_name)
    { questionary: :user, event: :calendar, news: 'list-alt', letter: :envelope }[model_name]
  end

  def permitted_to_anything_in_admin_menu?
    menu_item_collection.map do |item|
      if item.is_a? Hash
        item.values.first.map do |type|
          permitted_to?(:review, type) || permitted_to?(:index, type)
        end
      end
    end.flatten.include? true
  end
end
