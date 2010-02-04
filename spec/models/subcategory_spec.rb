require 'spec_helper'

describe Subcategory do
  before(:each) do
    @valid_attributes = {
      :name => "test subcategory"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Subcategory.create!(@valid_attributes)
  end
 
  it { should validate_presence_of :name }
  
  it "should print out the name when #to_s is called" do
    @subcategory = Subcategory.create(@valid_attributes)
    @subcategory.to_s.should == 'test subcategory'
  end

end
