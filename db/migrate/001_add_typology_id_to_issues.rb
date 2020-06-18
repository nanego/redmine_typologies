class AddTypologyIdToIssues < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :typology_id, :integer, :default => nil
    add_index :issues, :typology_id
  end
end
