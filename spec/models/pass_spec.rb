require 'rails_helper'

RSpec.describe Pass, type: :model do
  let(:user) {create(:user)}
  let(:category) {create(:category, category_name: "Student", discount: 10)}
  let(:offer) {create(:offer, amount: 100, validity: 30)}
  let(:pass) {Pass.new(offer: offer, category: category, user: user)}
  #association fails methods
  let(:invalid_offer) {build(:pass, offer: nil )}
  let(:invalid_pass_user) {build(:pass, user: nil)}
  let(:invalid_pass_category){build(:pass, category: nil)}

  describe "Assocition" do
    context "belongs_to" do 
      it { should belong_to :category}
      it {should belong_to :user }
      it {should belong_to :offer}
   end
  end

 describe "before save callback" do 
    it "sets the total_amount correctly" do 
      pass.save
      expect(pass.total_amount).to eq(90)
      expect(pass[:issue_date]).to eq(Date.today)
      expect(pass[:expiry_date]).to eq(Date.today + 30)
    end
 end

  describe "Validation" do 
    it "pass create errros validation offer"do 
      invalid_offer.save 
      expect(invalid_offer.offer).to eq(nil)
    end

    it "invalid_pass_user" do  
      invalid_pass_user.save
      expect(invalid_pass_user.user).to eq(nil)
    end
    
    it "invalid_pass_category" do  
      invalid_pass_category.save
      expect(invalid_pass_category).not_to be_valid
    end
  end
end
