require File.dirname(__FILE__) + '/../spec_helper'

describe SubcategoriesController do
  describe "hitting #index" do
    before(:each) do
      get :index
    end

    it { response.should be_success }
    it { response.should render_template("subcategories/index") }
    it "should assign @subcategories as an array" do
      assigns(:subcategories).should be_a(Array)
    end
  end

  describe "hitting #show with an id" do
    before(:each) do
      build :subcategory
      get :show, { :id => @subcategory.id }
    end

    it { response.should be_success }
    it { response.should render_template("subcategories/show") }
    it "should assign @subcategory" do
      assigns(:subcategory).should be_a(Subcategory)
    end
  end

  describe "hitting #new" do
    before(:each) do
      get :new
    end

    it { response.should be_success }
    it { response.should render_template("subcategories/new") }
    it "should assign @subcategory.category as a new Subcategory" do
      assigns(:subcategory).should be_a(Subcategory)
      assigns(:subcategory).id.should be_nil
    end
  end
  
  describe "posting to #create" do
    before(:each) do
     @old_subcategory_count = Subcategory.count
    end

    describe "with valid parameters" do
      it "should redirect to the subcategory path" do
        post :create, { :subcategory => { :name => "foo" } }
        response.should redirect_to(subcategory_path(Subcategory.last.id))
      end
    end
                                  
                        
    describe "with invalid parameters" do
      before(:each) do
        post :create, { :subcategory => { :name => nil } }
        @new_subcategory_count = Subcategory.count
      end
                                      
      it { response.should render_template("subcategories/new") }
                                            
      it "should assign a @subcategory that has errors" do
        assigns(:subcategory).should be_a(Subcategory)
        assigns(:subcategory).id.should be_nil
        @new_subcategory_count.should == @old_subcategory_count
        assigns(:subcategory).errors.to_a.should_not be_empty
      end
    end
  end

  describe "DELETEing to #destroy" do
    before(:each) do
      build :subcategory
    end

    describe "successfully" do
      before(:each) do
        class Subcategory < ActiveRecord::Base
          def destroy
            super
          end
        end
        delete :destroy, { :id => @subcategory.id }
      end

      it { response.should redirect_to(subcategory_path(@category)) }
    end
                          
    describe "unsuccessfully" do
      before(:each) do
        class Subcategory < ActiveRecord::Base
          def destroy
            false
          end
        end
        delete :destroy, { :id => @subcategory.id }
      end

      it { response.should render_template("subcategories/show")}
    end
  end

  describe "PUTing to #update" do
    before(:each) do
      build :subcategory
    end

    describe "successfully" do
      before(:each) do
        put :update, { :id => @subcategory.id, :category => {:name => "foo" } }
      end
                                      
      it { response.should redirect_to(subcategory_path(@subcategory)) }
    end
                          
    describe "unsuccessfully" do
      before(:each) do
        put :update, { :id => @subcategory.id, :category => { :name => nil } }
      end

      it { response.should render_template("subcategories/edit") }
    end
  end
end
