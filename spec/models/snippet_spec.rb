require 'spec_helper'

describe Snippet do
  before(:each) do
    @valid_attributes = {
      :name => "test snippet"
    }
  end

  it "should create a new instance given valid attributes" do
    Snippet.create!(@valid_attributes)
  end

  it { should validate_presence_of :name }

  it "should print out the name when #to_s is called" do
    @snippet = Snippet.create(@valid_attributes)
    @snippet.to_s.should == "test snippet"
  end

end 
