module Web::Admin::MenuHelper
  def menu_item_collection
    [{ people: [ :questionary ] }]
  end

  def model_icon(model_name)
    { questionary: :user }[model_name]
  end
end
