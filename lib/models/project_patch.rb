require_dependency 'project'

class Project

  has_many :project_typologies

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
      association.tracker_id = values[:tracker].present? ? values[:tracker].to_i : nil
      association.save
    end
  end

  def tracker_for(typology:)
    association = ProjectTypology.where(project: self, typology: typology).first
    association.blank? ? nil : association.tracker
  end

end
