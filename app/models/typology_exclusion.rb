class TypologyExclusion < ActiveRecord::Base
  belongs_to :project
  belongs_to :typology
end
