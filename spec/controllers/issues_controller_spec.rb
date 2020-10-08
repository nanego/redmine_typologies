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

  let!(:user) { User.find(1) }
  let!(:project) { Project.find(1) }
  let!(:typology_1) { Typology.create(name: "Typo1") }
  let!(:typology_2) { Typology.create(name: "Typo2") }

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

  describe "new issue creation" do
    it "creates a new issue with a typology" do
      project.enable_module! :typologies

      expect {
        post :create, :params => {
            :project_id => 1,
            :issue => {
                :tracker_id => 3,
                :status_id => 2,
                :subject => 'This is the test_new issue',
                :description => 'This is the description',
                :priority_id => 5,
                :typology_id => typology_2.id
            },
        }
      }.to change(Issue, :count).by(1)

      issue = Issue.last
      expect(issue).not_to be_nil
      expect(issue.typology).to eq typology_2
    end

    it "does not create a new issue if typology is required and empty" do
      project.enable_module! :typologies
      WorkflowPermission.delete_all
      WorkflowPermission.create!(:old_status_id => 1, :tracker_id => 2, :role_id => 1, :field_name => 'typology_id', :rule => 'required')
      @request.session[:user_id] = 2

      expect {
        post :create, :params => {
            :project_id => 1,
            :issue => {
                :tracker_id => 2,
                :status_id => 1,
                :subject => 'This is the test_new issue',
                :description => 'This is the description'
            },
        }
      }.to_not change(Issue, :count)

      expect(response).to be_successful
      expect(response.body).to match /Typology cannot be blank/
    end

    it "creates a new issue without a typology when module is NOT activated, even with 'required' workflow" do
      project.disable_module! :typologies
      WorkflowPermission.delete_all
      WorkflowPermission.create!(:old_status_id => 1, :tracker_id => 2, :role_id => 1, :field_name => 'typology_id', :rule => 'required')
      @request.session[:user_id] = 2

      expect {
        post :create, :params => {
            :project_id => 1,
            :issue => {
                :tracker_id => 2,
                :status_id => 1,
                :subject => 'This is the test_new issue',
                :description => 'This is the description'
            },
        }
      }.to change(Issue, :count).by(1)

      issue = Issue.last
      expect(response).to redirect_to issue_path(issue)
      expect(response.body).to_not match /Typology cannot be blank/
      expect(issue).not_to be_nil
      expect(issue.typology).to eq nil
    end
  end

end
