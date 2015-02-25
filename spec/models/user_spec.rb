require "spec_helper"
require "rails_helper"

describe User do
  
  before(:each) do
    @john = User.create(
      provider: "twitter",
      uid: 1,
      name: "John",
      email: "john@email.com")
  end

  it "is valid with provider, uid, name" do
    expect(@john).to be_valid
  end
  
  it "is invalid with dublicate name" do
    john2 = User.new(name: "John")
    expect(john2).to have(1).errors_on(:name)
  end

  it "is invalid with dublicate email" do
    john2 = User.new(email: "john@email.com")
    expect(john2).to have(1).errors_on(:email)
  end

  describe "#email_format" do
    
    it "is valid with correct email format" do
      expect(@john).to be_valid(:email)
    end

    it "is invalid without correct email format" do
      @john.update_attributes(email: "john@email")
      expect(@john).to have(1).errors_on(:email)

      @john.update_attributes(email: "johnemail")
      expect(@john).to have(1).errors_on(:email)

      @john.update_attributes(email: "johnemail.com")
      expect(@john).to have(1).errors_on(:email)
    end

  end

end