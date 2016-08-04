class ApplicationDecorator < Draper::Decorator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include RussianCases

  # FIXME add to more_html_tags including to draper
  include HTMLTagsHelpers
  include FontAwesome::Rails::IconHelper

  def decorated_to_json(options = {})
    hash = object.as_json options
    if options[:only].is_a? Array
      options[:only].each do |attribute|
        hash = add_to_hash_attributes hash, attribute
      end
    else
      hash = add_to_hash_attributes hash, options[:only]
    end
    hash.to_json
  end

  private

  def add_to_hash_attributes(hash, attribute)
    hash[attribute] = send attribute.to_s unless hash.keys.include? attribute
    hash
  end
end
