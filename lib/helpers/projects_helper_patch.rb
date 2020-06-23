require_dependency 'projects_helper'

module PluginTypology

  module ProjectsHelper

    def project_settings_tabs
      tabs = super
      if User.current.allowed_to?(:set_project_typologies, @project)
        tabs << {name: 'typologies', action: :admin_typologies, partial: 'projects/typologies', label: :project_module_typologies}
      end
      tabs
    end

  end

end

ProjectsHelper.prepend PluginTypology::ProjectsHelper
ActionView::Base.send(:include, ProjectsHelper)
