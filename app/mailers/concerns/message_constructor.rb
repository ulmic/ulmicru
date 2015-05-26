module Concerns
  module MessageConstructor
    def create_message(type, theme)
      messages_hash[type][theme]
    end

    private

    def messages_hash
      YAML.load_file("#{Rails.root}/lib/yaml/mail_messages.yml").with_indifferent_access[:messages]
    end
  end
end
