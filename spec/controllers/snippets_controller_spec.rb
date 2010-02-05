require File.dirname(__FILE__) + '/../spec_helper'

describe SnippetsController do
  describe "hitting #index" do
    before(:each) do
      get :index
    end

    it { response.should be_success }
    it { response.should render_template("snippets/index") }
    it "should assign @snippets as an array" do
      assigns(:snippets).should be_a(Array)
    end

  end

  describe "hitting #show with an id" do
    before(:each) do
      build :snippet
      get :show, { :id => @snippet.id }
    end

    it { response.should be_success }
    it { response.should render_template("snippets/show") }
    it "should assign @snippet" do
      assigns(:snippet).should be_a(Snippet)
    end

    describe "hitting #new" do
      before(:each) do
        get :new
      end

      it { response.should be_success }
      it { response.should render_template("snippets/new") }
      it "should assign @snippet as a new Snippet" do
        assigns(:snippet).should be_a(Snippet)
        assigns(:snippet).id.should be_nil
      end
    end

    describe "posting to #create" do
      before(:each) do
        @old_snippet_count = Snippet.count
      end

      describe "with valid parameters" do

        it "should redirect to the snippet path" do 
          post :create, { :snippet => { :name => "foo", :description => "bar" } }
          response.should redirect_to(snippet_path(Snippet.last.id))
        end

        it "should create and assign a @snippet" do
          assigns(:snippet).should be_a(Snippet)
          assigns(:snippet).id.should_not be_nil
        end

        it 'should change the snippet count by 1' do
           lambda do
            post :create, { :snippet => { :name => "foo", :description => "bar" } }
           end.should change(Snippet, :count).by(1)
        end

      end

      describe "with invalid parameters" do
        before(:each) do
          post :create, { :snippet => { :name => nil, :description => "bar" } }
          @new_snippet_count = Snippet.count
        end

        it { response.should render_template("snippets/new") }

        it "should assign a @snippet that has errors" do
          assigns(:snippet).should be_a(Snippet)
          assigns(:snippet).id.should be_nil
          @new_snippet_count.should == @old_snippet_count
          assigns(:snippet).errors.to_a.should_not be_empty
        end
      end
    end

    describe "DELETEing to #destroy_image" do
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
          delete :destroy, { :id => @image_id.id }
        end

        it { response.should redirect_to(snippets_path)}
      end

      describe "unsuccessfully" do
        before(:each) do
          class Image < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @image_id.id }
        end

        it { response.should render_template("snippets/show") }
      end
    end

    describe "DELETEing to #destroy" do
      before(:each) do
        build :snippet
      end

      describe "successfully" do
        before(:each) do
          class Snippet < ActiveRecord::Base
            def destroy
              super
            end
          end
          delete :destroy, { :id => @snippet.id }
        end

        it { response.should redirect_to(snippets_path)}
      end

      describe "unsuccessfully" do
        before(:each) do
          class Snippet < ActiveRecord::Base
            def destroy
              false
            end
          end
          delete :destroy, { :id => @snippet.id }
        end

        it { response.should render_template("snippets/show") }
      end
    end

    describe "PUTing to #update" do
      before(:each) do
        build :snippet
      end

      describe "successfully" do
        before(:each) do
          put :update, { :id => @snippet.id, :snippet => { :name => "jiggy" } }
        end

        it { response.should redirect_to(snippet_path(@snippet))}
      end

      describe "unsuccessfully" do
        before(:each) do
          put :update, { :id => @snippet.id, :snippet => { :name => nil } }
        end

        it { response.should render_template("snippets/edit") }
      end
    end
  end
end
