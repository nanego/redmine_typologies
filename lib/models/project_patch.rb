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
    if values_by_typology.present?
      values_by_typology.each do |typology_id, values|
        puts "typology_id : #{typology_id.inspect}"
        puts "values : #{values.inspect}"
        project_typology = ProjectTypology.find_or_create_by(typology_id: typology_id,
                                                        project: self)
        project_typology.active = values[:active].present? && values[:active] == '1'
        project_typology.tracker_ids = values[:tracker_ids].present? ? values[:tracker_ids] : []
        project_typology.save
      end
    end
  end

  def trackers_for(typology:)
    project_typology = ProjectTypology.where(project: self, typology: typology).first
    project_typology.blank? ? [] : project_typology.trackers
  end

end
