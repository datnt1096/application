require "rails_helper"

RSpec.describe UsersController, type: :controller do
  context "GET #show" do
    it "Return for succes respond" do
      user = User.create!(name: "my_name" , email: "my_name@gmail.com", password: "mypassword")
      get :show, params: {id: user.to_params}
      expect(response).to be_success
    end
  end
end
