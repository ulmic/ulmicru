class AddStateToActivityLinesCorporativeArguments < ActiveRecord::Migration
  def change
    add_column :activity_lines_corporative_arguments, :state, :text, default: :active
  end
end
