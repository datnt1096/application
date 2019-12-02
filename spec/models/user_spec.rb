require "rails_helper"

RSpec.describe User, type: :model do
  context "validations" do
    it "name" do
      is_expected.to validate_presence_of :name
    end

    it "name_length" do
      is_expected.to validate_length_of(:name).
        is_at_most Settings.title.max_length
    end

    it "email" do
      is_expected.to validate_presence_of :email
    end

    it "email_length" do
      is_expected.to validate_length_of(:email).
        is_at_most Settings.email.length
    end
  end

  context "columns" do
    it "have_name" do
      is_expected.to have_db_column :name
    end

    it "have_password" do
      is_expected.to have_db_column :password_digest
    end

    it "have_email" do
      is_expected.to have_db_column :email
    end

    it "have_img_url" do
      is_expected.to have_db_column :img_url
    end

    it "have_role" do
      is_expected.to have_db_column :role
    end
  end
end
