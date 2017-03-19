class AddRecordIdAndRecordTypeToProtocol < ActiveRecord::Migration
  def change
    add_column :protocols, :record_id, :integer
    add_column :protocols, :record_type, :text
  end
end
