# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  event_type_id :integer
#  user_id       :integer
#  name          :string
#  description   :text
#  phone         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  begins_at     :datetime
#

require "spec_helper"
require "rails_helper"

describe Event do
  
  before(:each) do
    @event = Event.new(
      author: User.new,
      name: "Some club",
      description: "DESC" * 10,
      phone: "123456789",
      location: Location.new,
      event_type_id: 1,
      begins_at: 1.day.from_now)
  end

  it "is valid with author, name, type, description, phone and location" do
    expect(@event).to be_valid
  end

  it "is valid with correct name length" do
    @event.name = "Some name"
    expect(@event).to be_valid
  end

  it "is invalid without correct name length" do
    @event.name = "N"
    expect(@event).to have(1).errors_on(:name)
  end

  it "is valid with correct description length" do
    @event.description = "DESC" * 10
    expect(@event).to be_valid
  end

  it "is invalid without correct description length" do
    @event.description = "D"
    expect(@event).to have(1).errors_on(:description)
  end

  it "is invalid without correct begins_at datetime" do
    @event.begins_at = 1.day.ago
    expect(@event).to have(1).errors_on(:begins_at)
  end

  it "returns a array of not started events" do
    @event.update_attributes(begins_at: 1.day.from_now)
    expect(Event.not_started).to eq [@event]
  end
end
