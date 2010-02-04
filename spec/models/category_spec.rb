require 'spec_helper'

describe Category do
  before(:each) do
    @valid_attributes = {
      :name => "test category"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Category.create!(@valid_attributes)
  end
 
  it { should validate_presence_of :name }
  
  it "should print out the name when #to_s is called" do
    @category = Category.create(@valid_attributes)
    @category.to_s.should == 'test category'
  end

end
