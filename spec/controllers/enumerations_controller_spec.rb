require "spec_helper"

RSpec.describe EnumerationsController, type: :controller do

  render_views

  fixtures :users, :enumerations

  let(:user) { User.find(1) }

  before do
    @request.session[:user_id] = 1
  end

  describe "index" do
    it "contains typologies" do
      get :index
      expect(response).to be_successful
      expect(response.body).to have_selector("h3:contains('Typologies')")
    end
  end

end
