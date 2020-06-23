class CreateTypologyExclusionsTable < ActiveRecord::Migration[5.2]
  def self.up
    create_table :typology_exclusions do |t|
      t.column :typology_id, :integer, :null => false
      t.column :project_id, :integer, :null => false
    end
    add_index :typology_exclusions, [:project_id, :typology_id], :unique => true, :name => :projects_typologies_ids
  end

  def self.down
    drop_table :typology_exclusions
  end
end
