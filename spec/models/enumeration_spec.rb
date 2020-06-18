require "spec_helper"

RSpec.describe Enumeration do
  describe "get_subclasses" do
    it 'includes Typology objects' do
      classes = Enumeration.get_subclasses
      expect(classes).to include IssuePriority
      expect(classes).to include DocumentCategory
      expect(classes).to include TimeEntryActivity
      expect(classes).to include Typology

      classes.each do |klass|
        expect(klass.superclass).to be Enumeration
      end
    end
  end
end
