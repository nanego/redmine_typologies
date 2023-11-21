module RedmineTypologies

  class Hooks < Redmine::Hook::ViewListener
    # adds plugin css on each page if needed
  end

  class ModelHook < Redmine::Hook::Listener
    def after_plugins_loaded(_context = {})
      require_relative 'models/issue_patch'
      require_relative 'models/tracker_patch'
      require_relative 'models/project_patch'
      require_relative 'models/issue_query_patch'
      require_relative 'helpers/issues_helper_patch'
      require_relative 'helpers/projects_helper_patch'
      require_relative '../../app/models/typology' # Force load the subclasses of Enumeration
    end
  end
end
