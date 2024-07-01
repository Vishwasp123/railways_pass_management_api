require 'rails_helper'

RSpec.describe Offer, type: :model do
  let(:offer) { create(:offer)}
  let(:offer_amount_invalid) { build(:offer, amount: nil)}
  let(:offer_validity_invalid) {build(:offer, validity: nil)}

  describe "Validation presence true" do
    context "validation" do 
      it "validation amount presence" do
        expect(offer).to  be_valid 
      end

      it "is not valid without an amount" do 
      expect(offer_amount_invalid).not_to be_valid
      expect(offer_amount_invalid.errors[:amount]).not_to be_empty 
      end

      it "is not valid without validity" do  
        expect(offer_validity_invalid).not_to be_valid
        expect(offer_validity_invalid.errors[:validity]).not_to be_empty
      end
    end 
  end

  describe "Assocition" do 
    context "has_many pass" do  
      it {expect(offer).to have_many(:pass).dependent(:destroy)}
    end
  end
end
