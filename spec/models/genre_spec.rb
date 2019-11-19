require "rails_helper"

RSpec.describe Genre, type: :model do
  context "validations" do
    it "title" do
       is_expected.to validate_presence_of :title
    end 
    it "name_length" do
      is_expected.to validate_length_of(:title).
        is_at_most Settings.title.max_length
    end
  end

  context "associations" do
    it "many_songs" do
      is_expected.to have_many(:songs).through :genre_songs
    end
  end

  context "columns" do
    it "have_title" do
      is_expected.to have_db_column :title
    end
  end
end
