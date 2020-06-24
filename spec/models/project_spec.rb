require 'spec_helper'

RSpec.describe Project do

  fixtures :trackers, :projects

  before do
    Typology.create(name: 'typo1')
    Typology.create(name: 'typo2')
  end

  describe "typology" do
    let(:project) { Project.find(1) }
    let(:typo1) { Typology.first }
    let(:typo2) { Typology.second }
    let(:tracker) { Tracker.first }

    it "allows projects to have default typologies" do
      expect(project.typologies).to eq [typo1, typo2]
    end

    it "updates disabled typologies per project" do
      ProjectTypology.create(project: project, typology: typo1, active: false)
      expect(project.typologies).to eq [typo2]
    end

    it 'can update project typologies' do
      expect(project.typologies).to eq [typo1, typo2]
      project.update_typologies({typo1.id => {active: '0'}})
      expect(project.typologies).to eq [typo2]
    end

    it 'can update tracker associated to typologies' do
      expect(project.typologies).to eq [typo1, typo2]
      expect(project.tracker_for(typology: typo1)).to be nil
      expect(project.tracker_for(typology: typo2)).to be nil

      project.update_typologies({typo1.id => {active: '1', tracker: tracker.id}})

      expect(project.typologies).to eq [typo1, typo2]
      expect(project.tracker_for(typology: typo1)).to eq tracker
      expect(project.tracker_for(typology: typo2)).to be nil
    end

  end

end
