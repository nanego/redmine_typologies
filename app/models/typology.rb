require_dependency "enumeration"

class Typology < Enumeration
  has_many :issues, :foreign_key => 'typology_id'

  after_destroy {|typology| typology.class.compute_position_names}
  after_save {|typology| typology.class.compute_position_names if (typology.saved_change_to_position? && typology.position) || typology.saved_change_to_active? || typology.saved_change_to_is_default?}

  OptionName = :enumeration_typologies

  def option_name
    OptionName
  end

  def objects_count
    issues.count
  end

  def transfer_relations(to)
    issues.update_all(:typology_id => to.id)
  end

  def css_classes
    "typology-#{id} typology-#{position_name}"
  end

  # Clears position_name for all typologies
  # Called from migration 20121026003537_populate_enumerations_position_name
  def self.clear_position_names
    update_all :position_name => nil
  end

  # Updates position_name for active typologies
  def self.compute_position_names
    typologies = where(:active => true).sort_by(&:position)
    if typologies.any?
      default = typologies.detect(&:is_default?) || typologies[(typologies.size - 1) / 2]
      typologies.each_with_index do |typology, index|
        name =
          case
          when typology.position == default.position
            "default"
          when typology.position < default.position
            index == 0 ? "lowest" : "low#{index+1}"
          else
            index == (typologies.size - 1) ? "highest" : "high#{typologies.size - index}"
          end

        where(:id => typology.id).update_all({:position_name => name})
      end
    end
  end
end
