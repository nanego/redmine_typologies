class AddMissingIndexes < ActiveRecord::Migration[7.2]
  def change
    add_index :project_typologies, :project_id, if_not_exists: true
    add_index :project_typologies, :typology_id, if_not_exists: true
    add_index :project_typologies_trackers, [:project_typology_id, :tracker_id], if_not_exists: true
  end
end
