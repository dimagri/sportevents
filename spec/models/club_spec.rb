require "spec_helper"
require "rails_helper"

describe Club do
  
  before(:each) do
    @club = Club.new(
      author: User.new,
      name: "Some club",
      description: "DESC" * 10,
      phone: "123456789",
      location: Location.new,
      club_type_id: 1)
  end

  it "is valid with author, name, type, description, phone and location" do
    expect(@club).to be_valid
  end

  it "is valid with correct name length" do
    @club.name = "Some name"
    expect(@club).to be_valid
  end

  it "is invalid without correct name length" do
    @club.name = "N"
    expect(@club).to have(1).errors_on(:name)
  end

  it "is valid with correct description length" do
    @club.description = "DESC" * 10
    expect(@club).to be_valid
  end

  it "is invalid without correct description length" do
    @club.description = "D"
    expect(@club).to have(1).errors_on(:description)
  end
end