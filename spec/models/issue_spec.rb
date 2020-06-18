require 'spec_helper'

RSpec.describe Issue do

  describe "typology" do
    let(:issue) { Issue.new }
    let(:typology) { Typology.new }

    it "allows issues to have a typology attribute" do
      issue.typology = typology
      expect(issue.typology).to be typology
    end

  end

end
