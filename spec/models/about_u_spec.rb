require 'rails_helper'

RSpec.describe AboutU, type: :model do

  describe "validations" do 
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:customer_support_contact)}
    it {should validate_presence_of(:headquaters_address)}
    it {should validate_presence_of(:email_address)}
  end
end
