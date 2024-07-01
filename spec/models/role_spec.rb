require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "validation" do 
    it "is valid with valid attributes" do 
      role = build(:role)
      expect(role).to be_valid
    end

    it "is not valid not without role type" do 
      role = build(:role, role_type: nil)
      expect(role).not_to be_valid
    end

    it "role uniqness " do  
      new_role = create(:role)
      role = build(:role, role_type: new_role.role_type)
      expect(role).not_to be_valid
    end
  end

 describe 'associations' do
    it 'has many users' do
      role = create(:role)
      user1 = create(:user, role: role)
      user2 = create(:user, username: "User2", role: role)
      expect(role.users).to include(user1, user2)
    end
  end
end
