class RenameUrlColumnInRedirectRules < ActiveRecord::Migration
  def change
    rename_column :redirect_rules, :url, :old_path
  end
end
