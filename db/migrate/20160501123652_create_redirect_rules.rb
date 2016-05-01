class CreateRedirectRules < ActiveRecord::Migration
  def change
    create_table :redirect_rules do |t|
      t.text :url
      t.text :redirect_to
      t.text :status
      t.text :reason
      t.text :state

      t.timestamps null: false
    end
  end
end
