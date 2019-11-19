require "rails_helper"

RSpec.describe Singer, type: :model do
  context "validations" do
    it "name" do
      is_expected.to validate_presence_of :name
    end
    it "name_length" do
      is_expected.to validate_length_of(:name).
        is_at_most Settings.title.max_length
    end
    it "content_length" do
      is_expected.to validate_length_of(:description).
        is_at_most Settings.content.max_length
    end
  end

  context "associations" do
    it "many_song" do
      is_expected.to have_many :songs
    end
  end

  context "columns" do
    it "have_name" do
      is_expected.to have_db_column :name
    end

    it "have_description" do
      is_expected.to have_db_column :description
    end
  end
end
