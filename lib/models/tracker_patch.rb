require_dependency "tracker"

class Tracker

  #Add typology_id to core fields 
  CORE_FIELDS = CORE_FIELDS.dup | ["typology_id"]
  CORE_FIELDS_ALL = (CORE_FIELDS_UNDISABLABLE + CORE_FIELDS).freeze

  has_and_belongs_to_many :project_typologies
  
end 
