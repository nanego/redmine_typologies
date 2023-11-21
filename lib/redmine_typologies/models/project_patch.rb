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

module RedmineTypologies::Models::ProjectPatch
  # Copies typologies from +project+
  def copy_typologies(project)
    # Prepare the hash in order to use the function update_typologies
    hash_typologies = {}
    project.project_typologies.each do |p_t|
      hash_typologies[p_t.typology_id] = { :active => p_t.active ? '1' : '0', :tracker_ids => p_t.tracker_ids }
    end
    self.update_typologies(hash_typologies)
  end

  def copy(project, options = {})
    super
    project = project.is_a?(Project) ? project : Project.find(project)

    to_be_copied = %w(typologies)

    to_be_copied = to_be_copied & Array.wrap(options[:only]) unless options[:only].nil?

    Project.transaction do
      if save
        reload

        to_be_copied.each do |name|
          send "copy_#{name}", project
        end

        save
      else
        false
      end
    end
  end
end
Project.prepend RedmineTypologies::Models::ProjectPatch
