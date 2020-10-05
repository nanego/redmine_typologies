require_dependency 'project'

class Project

  has_many :project_typologies, dependent: :destroy

  def typologies
    Typology.active.sorted - excluded_typologies
  end

  def excluded_typologies
    Typology.joins(:project_typologies)
        .where('project_typologies.project_id = ? AND project_typologies.active = ?', self.id, false)
  end

  def update_typologies(values_by_typology)
    values_by_typology.each do |typology_id, values|
      association = ProjectTypology.find_or_create_by(typology_id: typology_id,
                                       project: self)
      association.active = values[:active].present? && values[:active] == '1'
      association.tracker_ids = values[:tracker_ids].present? ? values[:tracker_ids] : []
      association.save
    end
  end

  def trackers_for(typology:)
    project_typology = ProjectTypology.where(project: self, typology: typology).first
    project_typology.blank? ? [] : project_typology.trackers
  end

end
