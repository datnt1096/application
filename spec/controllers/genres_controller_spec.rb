require "rails_helper"
require "factory_bot"

FactoryBot.define do
  factory :genre do
    title "test"
  end
end

RSpec.describe GenresController, type: :controller do
  let(:genre){FactoryBot.create :genre}

  context "GET #show" do
    it "Should show genre" do
      get :show, params: {id: genre.id}
      expect(response).to be_success
    end
  end
end
