require "spec_helper"

RSpec.describe IssuesController, type: :controller do

  render_views

  fixtures :users, :enumerations, :projects, :trackers, :issues,
            :email_addresses, :user_preferences,
            :roles,
            :members,
            :member_roles,
            :issue_statuses,
            :issue_relations,
            :versions,
            :projects_trackers,
            :issue_categories,
            :enabled_modules,
            :enumerations,
            :attachments,
            :workflows,
            :custom_fields,
            :custom_values,
            :custom_fields_projects,
            :custom_fields_trackers,
            :time_entries,
            :journals,
            :journal_details,
            :queries,
            :repositories,
            :changesets,
            :watchers

  let(:user) { User.find(1) }
  let(:project) { Project.find(1) }

  before do
    @request.session[:user_id] = 1
  end

  describe "new issue form" do
    it "hides typology field if module is disabled" do
      project.disable_module! :typologies
      get :new, params: {project_id: project.id}
      expect(response).to be_successful
      expect(response.body).to_not have_selector("label:contains('Typology')")
    end

    it "shows typology field if module is enabled" do
      project.enable_module! :typologies
      get :new, params: {project_id: project.id}
      expect(response).to be_successful
      expect(response.body).to have_selector("label:contains('Typology')")
    end
  end

end
