class AddMissingIndexes < ActiveRecord::Migration[6.1]
  def change
    add_index :project_typologies, :project_id, if_not_exists: true
    add_index :project_typologies, :typology_id, if_not_exists: true
    add_index :project_typologies_trackers, [:project_typology_id, :tracker_id], if_not_exists: true, name: "index_project_typologies_trackers"
  end
end
