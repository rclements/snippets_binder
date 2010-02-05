require 'spec_helper'

describe Image do
  before(:each) do
    Image.delete_all
    @valid_attributes = 
      { :image_file_file_name => "bing"
    }
    @image = Image.create!(@valid_attributes)
  end

  it "should respond false on call to deleted?" do
    @image.deleted?.should == false
  end

  describe "on call to delete" do
    before(:all) do
      @image.delete
    end

    it "should set the deleted at attribute" do
      @image.deleted_at.should_not == nil
    end

    it "should respond true on call to deleted?" do
      @image.deleted?.should == true
    end
  end
end
