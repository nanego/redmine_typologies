class CreateProjectTypologiesTable < ActiveRecord::Migration[5.2]
  def self.up
    create_table :project_typologies do |t|
      t.column :typology_id, :integer, :null => false
      t.column :project_id, :integer, :null => false
      t.column :tracker_id, :integer
      t.column :active, :boolean
    end
    add_index :project_typologies, [:project_id, :typology_id], :unique => true, :name => :projects_typologies_ids
  end

  def self.down
    drop_table :project_typologies
  end
end
