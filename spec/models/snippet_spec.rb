require 'spec_helper'

describe Snippet do
  before(:all) do
    Snippet.delete_all
    @valid_attributes = {
      :name => "test snippet"
    }
    @snippet = Snippet.create!(@valid_attributes)
  end

  it { should validate_presence_of :name }

  it "should print out the name when #to_s is called" do
    @snippet.to_s.should == "test snippet"
  end

  it "should respond false on call to deleted?" do
    @snippet.deleted?.should == false
  end
  
  describe "with some associated images" do
    before(:all) do
      build :image
      @snippet.images << Image.last
    end

    describe "then on a call to delete" do
      before(:all) do
        @snippet.delete
      end

      it "should set the deleted at attribute" do
        @snippet.deleted_at.should_not == nil
      end

      it "should respond true on call to deleted?" do
        @snippet.deleted?.should == true
      end
    end
  end
end
