# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :string
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require "spec_helper"
require "rails_helper"

describe Comment do
  before(:each) do
    @comment = Comment.create(
      user_id: 1,
      commentable: Club.new,
      body: "Comment text")
  end
  
  it "is valid with user, commentable, body" do
    expect(@comment).to be_valid
  end

  it "is invalid without user" do
    @comment.user_id = nil
    expect(@comment).to have(1).errors_on(:user_id)
  end

  it "is invalid without commentable" do
    @comment.commentable = nil
    expect(@comment).to have(1).errors_on(:commentable)
  end

  it "is invalid without body" do
    @comment.body = ''
    expect(@comment).to have(2).errors_on(:body)
  end

  it "is invalid without correct body length" do    
    @comment.body = "a" * 160
    expect(@comment).to have(1).errors_on(:body)
  end

  it "is valid with correct body length" do
    @comment.body = 'Some comment'
    expect(@comment).to be_valid
  end

  it "returns a sorted array of comments" do
    @comment2 = Comment.create(
      user_id: 1,
      commentable: Club.new,
      body: "Comment text2")
    expect(Comment.ordered).to eq [@comment2, @comment]
  end

end
