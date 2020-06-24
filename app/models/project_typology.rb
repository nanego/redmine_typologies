class ProjectTypology < ActiveRecord::Base

  belongs_to :project
  belongs_to :typology
  belongs_to :tracker, optional: true

end
