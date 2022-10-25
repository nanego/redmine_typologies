require_dependency 'projects_helper'

module PluginTypology

  module ProjectsHelper

    def project_settings_tabs
      tabs = super
      if User.current.allowed_to?(:set_project_typologies, @project)
        typologies_tab = {name: 'typologies', action: :admin_typologies, partial: 'projects/typologies', label: :project_module_typologies}
        if tabs.size > 5
          tabs.insert(5, typologies_tab)
        else
          tabs << typologies_tab
        end
      end
      tabs
    end

    def render_api_includes(project, api)
      super
      api.array :typologies do
        if project.module_enabled?("typologies")
          project.typologies.each do |typology|
            api.typology(:id => typology.id, :name => typology.name)
          end
        end
      end if include_in_api_response?('typologies')

    end
  end

end

ProjectsHelper.prepend PluginTypology::ProjectsHelper
ActionView::Base.send(:include, ProjectsHelper)
