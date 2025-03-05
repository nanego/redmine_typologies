class ProjectTypology < ApplicationRecord

  belongs_to :project
  belongs_to :typology
  has_and_belongs_to_many :trackers

end
