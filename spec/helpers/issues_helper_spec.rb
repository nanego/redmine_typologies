require 'spec_helper'

RSpec.describe IssuesHelper, type: :helper do

  let(:typology_1) { Typology.create(name: "Typo1") }
  let(:typology_2) { Typology.create(name: "Typo2") }

  it "shows old and new values with a typology update" do
    detail = JournalDetail.new(:property => 'attr', :prop_key => 'typology_id',
                               :old_value => typology_1.id, :value => typology_2.id)
    expect(show_detail(detail, true)).to match /Typo1/
    expect(show_detail(detail, true)).to match /Typo2/
  end
end
