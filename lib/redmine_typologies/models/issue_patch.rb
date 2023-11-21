require_dependency 'issue'

module RedmineTypologies::Models::IssuePatch

end

class Issue

  include RedmineTypologies::Models::IssuePatch

  belongs_to :typology, optional: true

  safe_attributes :typology_id

  # Validates the issue against additional workflow requirements
  def validate_required_fields
    user = new_record? ? author : current_journal.try(:user)

    required_attribute_names(user).each do |attribute|
      if /^\d+$/.match?(attribute)
        attribute = attribute.to_i
        v = custom_field_values.detect { |v| v.custom_field_id == attribute }
        if v && Array(v.value).detect(&:present?).nil?
          errors.add(v.custom_field.name, l('activerecord.errors.messages.blank'))
        end
      else
        if respond_to?(attribute) && send(attribute).blank? && !disabled_core_fields.include?(attribute)
          next if attribute == 'category_id' && project.try(:issue_categories).blank?
          next if attribute == 'fixed_version_id' && assignable_versions.blank?

          #####
          # START PATCH
          if respond_to?("validate_required_#{attribute}_field")
            next if send("validate_required_#{attribute}_field", attribute)
          end
          # END PATCH
          #####

          errors.add attribute, :blank
        end
      end
    end
  end

  def validate_required_typology_id_field(attribute)
    return true if attribute == 'typology_id' && !project.module_enabled?('typologies')
    return true if attribute == 'typology_id' && project.typologies.blank?

    return false
  end
end
