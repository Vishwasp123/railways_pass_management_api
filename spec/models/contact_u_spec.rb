require 'rails_helper'

RSpec.describe ContactU, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:phone_number)}
  it {should validate_presence_of(:message)}
end
