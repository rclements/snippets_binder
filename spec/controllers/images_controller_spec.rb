require File.dirname(__FILE__) + '/../spec_helper'

describe ImagesController do
  describe "hitting #new" do
    before(:each) do
     get :new
    end

    it { response.should be_success }
    it { response.should render_template("images/new") }
    it "should assign @image as new Image" do
      assigns(:image).should be_a(Image)
      assigns(:image).id.should be_nil
    end
  end

  describe "hitting #show with an id" do
    before(:each) do
      build :image
      get :show, { :id => @image.id }
    end

    
    it { response.should be_success }
    it { response.should render_template("images/show") }
    it "should assign @image" do
      assigns(:image).should be_a(Image)
    end
  end

  describe "hitting #new" do
    before(:each) do
      get :new
    end

    it { response.should be_success }
    it { response.should render_template("images/new") }
    it "should assign @image as a new Image" do
      assigns(:image).should be_a(Image)
      assigns(:image).id.should be_nil
    end
  end
  
  describe "DELETEing to #destroy" do
    before(:each) do
      build :image
    end

    describe "successfully" do
      before(:each) do
        class Image < ActiveRecord::Base
          def destroy
            super
          end
        end
        delete :destroy, { :id => @image.id }
      end

      it { response.should redirect_to('/') }
    end

    describe "unsuccessfuly" do
      before(:each) do
        class Image < ActiveRecord::Base
          def destroy
            false
          end
        end
        delete :destroy, { :id => @image.id }
      end

      it { response.should render_template("images/show") }
    end
  end

  describe "posting to #create" do
    before(:each) do
      @old_image_count = Image.count
  end

    describe "with valid parameters" do
      before(:each) do
        post :create, {:image => { :id => 1 } }
        @new_image_count = Image.count
      end
    end
     it { response.should redirect_to(image_path(Image.last.id)) }

     it "should create and assign a @image" do
       assigns(:image).should be_a(Image)
       assigns(:image).id.should_not_be_nil
       @new_image_count.should == @old_snippet_count + 1
    end
  end
end
