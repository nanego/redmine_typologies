require_relative 'lib/redmine_typologies/hooks'

Redmine::Plugin.register :redmine_typologies do
  name 'Redmine Issue Typologies plugin'
  author 'Vincent ROBERT'
  description 'This is a plugin for Redmine which adds a new Typology field to issues'
  version '0.0.1'
  url 'https://github.com/nanego/redmine_typologies'
  author_url 'https://github.com/nanego'
  project_module :typologies do
    permission :set_project_typologies, {}
  end
end
