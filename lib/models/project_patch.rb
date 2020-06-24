require_dependency 'project'

class Project

  has_many :typology_exclusions
  has_many :excluded_typologies, through: :typology_exclusions, source: :typology

  def typologies
    Typology.active.sorted - excluded_typologies
  end

  def update_typologies(checked_typologies_ids)
    exclusions = []
    Typology.active.where.not(id: checked_typologies_ids).each do |typology|
      exclusions << TypologyExclusion.new(typology: typology, project: self)
    end
    if self.typology_exclusions != exclusions
      self.typology_exclusions.destroy_all
      self.typology_exclusions = exclusions
      self.save
    end
  end

end
