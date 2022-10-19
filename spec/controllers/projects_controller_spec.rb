require "spec_helper"

describe ProjectsController, :type => :controller do
  fixtures  :users, :projects, :enumerations
  render_views

  before do
    @request.session[:user_id] = 1
  end

  describe "copy a project" do
    let(:source_project) { Project.find(2) }

    before do
      Typology.create(name: "typo1", active: true, is_default: true)
      Typology.create(name: "typo2", active: true)
      ProjectTypology.create(project_id: source_project.id, typology_id: Typology.first.id, active: true, tracker_ids: [1, 2])
      ProjectTypology.create(project_id: source_project.id, typology_id: Typology.last.id, active: false, tracker_ids: [1, 3])
    end

    it "Copy all typologies" do
      expect do
        post :copy, :params => {
          :id => source_project.id,
          :project => {
            :name => 'test project',
            :identifier => 'test-project'
          },
          :only => %w(typologies)
        }
      end.to change { ProjectTypology.count }.by(2)

      new_pro = Project.last

      pt1 = ProjectTypology.where(project_id: new_pro.id).first
      pt2 = ProjectTypology.where(project_id: new_pro.id).last

      expect(pt1.typology_id).to eq(Typology.first.id)
      expect(pt2.typology_id).to eq(Typology.last.id)
      expect(pt1.active).to eq(true)
      expect(pt2.active).to eq(false)
      expect(pt1.tracker_ids).to eq([1, 2])
      expect(pt2.tracker_ids).to eq([1, 3])

    end

    it "should display active typologies in project/show api" do
      source_project.is_public = true;
      source_project.save

      typology_first = Typology.first
      typology_second = Typology.last

      get :show, params: {:id => source_project.identifier, :include => ["typologies"], :format => 'json' }
      expect(response).to have_http_status(200)

      st_first = "{\"id\":#{typology_first.id},\"name\":\"#{typology_first.name}\"}"
      expect(response.body).to include(st_first)

      st_second = "{\"id\":#{typology_second.id},\"name\":\"#{typology_second.name}\"}"
      expect(response.body).not_to include(st_second)
    end

  end
end