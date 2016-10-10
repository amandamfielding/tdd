require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:username)}
  it {should validate_presence_of(:password_digest)}
  it {should validate_presence_of(:session_token)}
  it {should validate_length_of(:password).is_at_least(6)}
  it {should have_many(:goals)}

  describe '::find_by_credentials' do
    context "when given valid params" do
      it "returns user" do
        user1 = User.create(username: '123', password: '123456')
        expect(User.find_by_credentials('123', '123456')).to eq(user1)
      end
    end

    context "when given invalid params" do
      it "returns nil" do
        user1 = User.create(username: '123', password: '123456')
        expect(User.find_by_credentials('123', '1234567')).to be_nil
      end
    end
  end

  describe '#password=' do
    it 'sets BCrypt Password' do
      expect(BCrypt::Password).to receive(:create)
      User.new(username: "mandy", password:"password")
    end

    it "doesn't save the password to database" do
      User.create!(username: "mandy", password:"password")
      user = User.find_by(username: "mandy")
      expect(user.password).not_to be("password")
    end
  end

  describe "reset_token!" do
    it "uses SecureRandom to set session_token" do
      user1 = User.create!(username: '123', password: '123456')
      expect(user1.session_token).not_to be_nil
    end
  end
end
