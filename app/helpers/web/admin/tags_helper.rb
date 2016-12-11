module Web::Admin::TagsHelper
  def admin_tags_record_path(instance)
    send("admin_#{instance.model_name.name.underscore.gsub('/', '_')}_path", instance.id)
  end
end
