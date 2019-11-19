require "rails_helper"

RSpec.describe Comment, type: :model do
  context "validations" do
    it "content_length" do
      is_expected.to validate_length_of(:content).
        is_at_most Settings.content.max_length
    end
  end

  context "associations" do
    it "belongs_user" do
       is_expected.to belong_to :user
    end
    it "belongs_song" do
       is_expected.to belong_to :song
    end
  end

  context "columns" do
    it "have_song_id" do
      is_expected.to have_db_column :song_id
    end

    it "have_user_id" do
      is_expected.to have_db_column :user_id
    end

    it "have_content" do
      is_expected.to have_db_column :content
    end
  end
end
