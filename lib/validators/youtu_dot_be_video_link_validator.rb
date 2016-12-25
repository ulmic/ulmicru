class YoutuDotBeVideoLinkValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      unless value =~ /youtu.be/
        record.errors.add(attribute, :video_link, options.merge(value: value))
      end
    end
  end
end
