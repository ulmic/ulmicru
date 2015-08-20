require 'csv'

module Data::Tags
  def upload_tags(filepath)
    csv_text = File.read filepath
    csv = CSV.parse csv_text
    hash = {}
    csv.each do |tag|
      Tag.create text: tag[1], tag_type: tag[2], record_id: tag[3], record_type: tag[4], target_id: tag[5], target_type: tag[6]
    end
  end
end
