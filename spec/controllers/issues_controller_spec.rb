require "spec_helper"

RSpec.describe IssuesController, type: :controller do

  render_views

  fixtures :users, :enumerations, :projects, :trackers, :issues

  let(:user) { User.find(1) }

  before do
    @request.session[:user_id] = 1
  end

  describe "new issue form" do
    it "allows user to select a typology" do
      get :new
      expect(response).to be_successful
      expect(response.body).to have_selector("label:contains('Typology')")
    end
  end

end
