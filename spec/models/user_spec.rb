require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_role) {create(:role, role_type: 'User')}
  let(:category) {create(:category, category_name: "Student", discount: 10)}
  let(:offer) {create(:offer, amount: 100, validity: 30)}

  describe "validation" do 

    it 'is valid with valid attributes' do
      user = create(:user, role: user_role)
      expect(user).to be_valid
    end

    it "is not valid with out username" do  
      user = build(:user, username: nil, role: user_role)
      expect(user).not_to be_valid
    end

    it "user not crate duplicate user" do  
      new_user = create(:user, role: user_role)
      user = build(:user, username: new_user.username, role: user_role)
      expect(user).not_to be_valid
    end
  end

  describe "Association" do 
    it "belongs_to role" do 
      user = create(:user, role: user_role)
      expect(user.role).to eq(user_role)
    end

    it "has one pass" do 
      user = create(:user, role: user_role)
      pass = create(:pass, user: user, category: category, offer: offer)
      expect(user.pass).to eq(pass)
    end
  end

  describe "before validation" do 
    it " set the default user" do 
      user = create(:user, role: user_role)
      expect(user.role).to eq(user_role)
    end
  end
end
