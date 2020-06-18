require_dependency 'issue'

class Issue

  belongs_to :typology, optional: true

  safe_attributes :typology_id

end
