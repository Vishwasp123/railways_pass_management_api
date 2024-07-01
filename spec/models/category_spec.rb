require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validation" do 
    it "with valid attributes" do 
      category = build(:category)
      expect(category).to be_valid
    end

    it "without valid attributes" do  
      category = build(:category, category_name: nil )
      expect(category).not_to be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:passes).dependent(:destroy) }
  end
end
