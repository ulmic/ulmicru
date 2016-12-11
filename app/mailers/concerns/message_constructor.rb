module Concerns
  module MessageConstructor
    def create_message(type, theme)
      messages_hash[type][theme]
    end

    def subject(obj_class, theme, admin = nil)
      type = admin ? obj_class.name.underscore : class_to_type(obj_class)
      messages_hash[type][theme][:subject]
    end

    private

    def messages_hash
      YAML.load_file("#{Rails.root}/lib/yaml/mail_messages.yml").with_indifferent_access[:messages]
    end

    def class_to_type(obj_class)
      if !((class_name = obj_class.name.underscore).in? %w[member questionary])
        class_name
      else
        'user'
      end
    end
  end
end
