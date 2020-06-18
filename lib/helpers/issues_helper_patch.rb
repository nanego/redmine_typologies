require_dependency 'issues_helper'
include ERB::Util

module PluginTypology
  module IssuesHelperPatch

    # Returns the textual representation of a single journal detail
    # Core properties are 'attr', 'attachment' or 'cf' : this patch specify how to display 'attr' journal details when the updated field is 'authorized_viewers'
    def show_detail(detail, no_html = false, options = {})

      if detail.property == 'attr' && detail.prop_key == 'typology_id'

        field = detail.prop_key.to_s.gsub(/\_id$/, "")
        label = l(("field_" + field).to_sym)
        value = find_name_by_reflection(field, detail.value)
        old_value = find_name_by_reflection(field, detail.old_value)

        unless no_html
          label = content_tag('strong', label)
          old_value = content_tag("i", h(old_value)) if detail.old_value
          if detail.old_value && detail.value.blank?
            old_value = content_tag("del", old_value)
          end
          value = content_tag("i", h(value)) if value
        end

        if detail.value.present?
          if detail.old_value.present?
            l(:text_journal_changed, :label => label, :old => old_value, :new => value).html_safe
          else
            l(:text_journal_set_to, :label => label, :value => value).html_safe
          end
        else
          l(:text_journal_deleted, :label => label, :old => old_value).html_safe
        end

      else
        # Process standard fields
        super
      end
    end
  end

end

IssuesHelper.prepend PluginTypology::IssuesHelperPatch
ActionView::Base.prepend IssuesHelper
