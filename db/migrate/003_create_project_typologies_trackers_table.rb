class CreateProjectTypologiesTrackersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :project_typologies_trackers, :id => false do |t|
      t.belongs_to :project_typology
      t.belongs_to :tracker
    end
    remove_column :project_typologies, :tracker_id, :integer
  end
end
