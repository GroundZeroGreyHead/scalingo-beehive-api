require 'rails_helper'

RSpec.describe Beehive, type: :model do
  it "has a valid factory" do
    expect(build(:beehive)).to be_valid
  end

  it "is invalid without a name" do
    beehive = build(:beehive, name: nil)
    expect(beehive).to be_invalid
    expect(beehive.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a name shorter than 6 characters" do
    beehive = build(:beehive, name: "short")
    expect(beehive).to be_invalid
    expect(beehive.errors[:name]).to include("is too short (minimum is 6 characters)")
  end

  it "is invalid without a weight" do
    beehive = build(:beehive, weight: nil)
    expect(beehive).to be_invalid
    expect(beehive.errors[:weight]).to include("can't be blank")
  end

  it "is invalid with a weight greater than 1000" do
    beehive = build(:beehive, weight: 1001)
    expect(beehive).to be_invalid
    expect(beehive.errors[:weight]).to include("must be less than or equal to 1000")
  end

  it "is invalid with a weight less than 0" do
    beehive = build(:beehive, weight: -1)
    expect(beehive).to be_invalid
    expect(beehive.errors[:weight]).to include("must be greater than or equal to 0")
  end
end
