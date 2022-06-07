require "spec_helper"

describe ProjectsController, :type => :controller do
  fixtures  :users, :projects, :enumerations

  before do
    @request.session[:user_id] = 1
  end

  describe "copy a project" do
    let(:source_project) { Project.find(2) }

    it "Copy all typologies" do
      Typology.create(name: "typo1", active: true, is_default: true)
      Typology.create(name: "typo2", active: true)
      ProjectTypology.create(project_id: source_project.id, typology_id: Typology.first.id, active: true, tracker_ids: [1, 2])
      ProjectTypology.create(project_id: source_project.id, typology_id: Typology.last.id, active: false, tracker_ids: [1, 3])

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
  end
end