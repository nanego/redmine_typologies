require_dependency 'issue'

class Issue

  belongs_to :typology, optional: true

end
