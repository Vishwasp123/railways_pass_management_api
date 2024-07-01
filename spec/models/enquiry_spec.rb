require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  describe "validations" do 
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:subject)}
    it {should validate_presence_of(:message)}
  end
end
