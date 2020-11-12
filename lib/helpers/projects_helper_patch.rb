require_dependency 'projects_helper'

module PluginTypology

  module ProjectsHelper

    def project_settings_tabs
      tabs = super
      if User.current.allowed_to?(:set_project_typologies, @project)
        typologies_tab = {name: 'typologies', action: :admin_typologies, partial: 'projects/typologies', label: :project_module_typologies}
        if tabs.size > 6
          tabs.insert(6, typologies_tab)
        else
          tabs << typologies_tab
        end
      end
      tabs
    end

  end

end

ProjectsHelper.prepend PluginTypology::ProjectsHelper
ActionView::Base.send(:include, ProjectsHelper)
