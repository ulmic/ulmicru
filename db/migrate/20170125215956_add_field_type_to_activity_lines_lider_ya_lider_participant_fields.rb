class AddFieldTypeToActivityLinesLiderYaLiderParticipantFields < ActiveRecord::Migration
  def change
    add_column :activity_lines_lider_ya_lider_participant_fields, :field_type, :text, default: :text
  end
end
