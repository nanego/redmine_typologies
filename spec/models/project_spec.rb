require 'spec_helper'

RSpec.describe Project do

  describe "typology" do
    let(:project) { Project.new }
    let(:typology) { Typology.new }

    it "allows projects to have typologies" do
      expect(project.typologies).to be_a_kind_of Array
    end

  end

end
