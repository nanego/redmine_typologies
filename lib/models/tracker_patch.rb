require_dependency "tracker"

class Tracker

  #Add typology_id to core fields 
  temp = CORE_FIELDS.dup
  temp << "typology_id"

  CORE_FIELDS = temp
  CORE_FIELDS_ALL = (CORE_FIELDS_UNDISABLABLE + CORE_FIELDS).freeze

  has_and_belongs_to_many :project_typologies
  
end 