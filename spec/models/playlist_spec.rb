require "rails_helper"

RSpec.describe Playlist, type: :model do
  context "validations" do
    it "name" do 
      is_expected.to validate_presence_of :name
      is_expected.to validate_length_of(:name).
        is_at_most Settings.title.max_length
    end

    it "user_id" do
      is_expected.to validate_presence_of :user_id
    end
    
    it "des_length" do
      is_expected.to validate_length_of(:description).
        is_at_most Settings.content.max_length
    end
  end

  context "associations" do
    it "belongs_user" do
      is_expected.to belong_to :user
    end

    it "many_songs" do
      is_expected.to have_many(:songs).through :playlist_songs
    end

    it "many_liked" do
      is_expected.to have_many :liked
    end
  end

  context "columns" do
    it "have_user_id" do
      is_expected.to have_db_column :user_id
    end

    it "have_name" do
      is_expected.to have_db_column :name
    end

    it "have_description" do
      is_expected.to have_db_column :description
    end

    it "have_url" do
      is_expected.to have_db_column :img_url
    end
  end
end
