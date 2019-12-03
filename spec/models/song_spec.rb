require "rails_helper"

RSpec.describe Song, type: :model do
  context "validations" do
    it "title" do
       is_expected.to validate_presence_of :title
    end

    it "title_length" do
      is_expected.to validate_length_of(:title).
        is_at_most Settings.title.max_length
    end

    it "song_url" do
      is_expected.to validate_presence_of :song_url
    end

    it "view" do
      is_expected.to validate_numericality_of :view
    end
  end

  context "associations" do
    it "belongs_singer" do
      is_expected.to belong_to :singer
    end

    it "many_liked" do
      is_expected.to have_many :liked
    end

    it "many_comments" do
      is_expected.to have_many :comments
    end

    it "many_views_logs" do
      is_expected.to have_many :view_logs
    end
  end

  context "columns" do
    it "have_singer_id" do
      is_expected.to have_db_column :singer_id
    end

    it "have_title" do
      is_expected.to have_db_column :title
    end

    it "have_lyrics" do
      is_expected.to have_db_column :lyrics
    end

    it "have_song_url" do
      is_expected.to have_db_column :song_url
    end

    it "have_view" do
      is_expected.to have_db_column :view
    end
  end
end
