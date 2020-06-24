ActiveSupport::Reloader.to_prepare do
  require_dependency 'models/enumeration_patch'
  require_dependency 'models/issue_patch'
  require_dependency 'models/project_patch'
  require_dependency 'models/issue_query_patch'
  require_dependency 'helpers/issues_helper_patch'
  require_dependency 'helpers/projects_helper_patch'
end

Redmine::Plugin.register :redmine_typologies do
  name 'Redmine Issue Typologies plugin'
  author 'Vincent ROBERT'
  description 'This is a plugin for Redmine which adds a new Typology field to issues'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  project_module :typologies do
    permission :set_project_typologies, {}
  end
end
