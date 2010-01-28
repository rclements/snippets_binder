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

  describe "hitting #index" do
    before(:each) do
      get :index
    end

    it { response.should be_success }
    it { response.should render_template("images/index") }
    it "should assign @images as an array" do
      assigns(:images).should be_a(Array)
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

      it { response.should redirect_to images_path }

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
    end
    
    it"should save the uploaded image" do
      image = mock(Image).as_null_object
      
      Image.should_receive(:new).and_return(image)
      uploaded_file = mock(ActionController::UploadedStringIO).as_null_object
      params = { "id" => "1", "image" => uploaded_file }
      image.should_receive(:save_upload).with(uploaded_file)
      post :save_file, params
    end

    it "should be able to save an upload with a unique id" do
      uploaded_file = mock(ActionController::UploadedStringIO).as_null_object
      uploaded_file.stub!(:original_filename).and_return('test.jpg')
      uploaded_file.stub!(:read).and_return("Some content") 

      image = Image.new

      image.save

  #    image.original_filename.should == "test.jpg"

    #  iamge.new_filename.should =~ /\d{2}\d{2}\d{4}\d{2}\d{2}\d{2}-test.jpg/
              
  #    File.exist?("#{Rails.root}/public/system/image_files/#{image.new_filename}").should == true
   #   File.open("#{Rails.root}/public/system/image_files/#{image.new_filename}", "r") { |f| f.read.should == uploaded_file.read}
    end
  
    describe "with valid parameters" do
     before(:each) do
        post :create, {:image => { :id => 1 } }
     end
    
#    { response.should redirect_to (image_path(Image)) }
                
    end

  end

end
