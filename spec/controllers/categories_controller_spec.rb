require File.dirname(__FILE__) + '/../spec_helper'
include Authlogic::TestCase

describe CategoriesController do

  describe "Authenticated examples" do
    before(:each) do
      activate_authlogic
      UserSession.create Factory.build(:valid_user)
    end

    describe "hitting #index" do
      before(:each) do
        get :index
      end

      it { response.should be_success }
      it { response.should render_template("categories/index") }
      it "should assign @categories as an array" do
        assigns(:categories).should be_a(Array)
      end
    end

    describe "hitting #show with an id" do
      before(:each) do
        build :category
        get :show, { :id => @category.id }
      end

      it { response.should be_success }
      it { response.should render_template("categories/show") }
      it "should assign @category" do
        assigns(:category).should be_a(Category)
      end
    end

    describe "hitting #show category with an id" do
      before(:each) do
        build :category
        get :show, { :id => @category.id }
      end

      it { response.should be_success }
      it { response.should render_template("categories/show") }
      it "should assign @category" do
        assigns(:category).should be_a (Category)
      end
    end

    describe "hitting #new" do
      before(:each) do
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("categories/new") }
      it "should assign @category as a new Category" do
        assigns(:category).should be_a(Category)
        assigns(:category).id.should be_nil
      end
    end
    describe "posting to #create" do
      before(:each) do
        @old_category_count = Category.count
      end

      describe "with valid parameters" do
        it "should redirect to the category path" do
          post :create, { :category => { :name => "foo" } }
          response.should redirect_to(category_path(Category.last.id))
        end

        it "should create and assign a @category" do
        end
        it 'should change the category count by 1' do
          lambda do
            post :create, { :category => { :name => "foo" } }
          end.should change(Category, :count).by(1)
        end
      end

      describe "with invalid parameters" do
        before(:each) do
          post :create, { :category => { :name => nil } }
          @new_category_count = Category.count
        end

        it { response.should render_template("categories/new") }

        it "should assign a @category that has errors" do
          assigns(:category).should be_a(Category)
          assigns(:category).id.should be_nil
          @new_category_count.should == @old_category_count
          assigns(:category).errors.to_a.should_not be_empty
        end
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        build :category
      end

      describe "successfully" do
        before(:each) do
          class Category < ActiveRecord::Base
            def destroy
              super
            end
          end
          delete :destroy, { :id => @category.id }
        end

        it { response.should redirect_to(categories_path) }
      end

      describe "unsuccessfully" do
        before(:each) do
          class Category < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @category.id }
        end

        it { response.should render_template("categories/show")}
      end
    end

    describe "PUTing to #update" do
      before(:each) do
        build :category
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @category.id, :category => {:name => "foo" } }
        end

        it { response.should redirect_to(category_path(@category)) }
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @category.id, :category => { :name => nil } }
        end

        it { response.should render_template("categories/edit") }
      end
    end
  end
end
