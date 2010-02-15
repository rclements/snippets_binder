class SnippetsController < ApplicationController
  before_filter :load_snippets
  before_filter :load_snippet, :only => [:show, :edit, :update, :destroy, :destroy_image]
  before_filter :load_new_snippet, :only => [:new, :create]
  before_filter :load_categories, :only => [:show, :new]
  before_filter :load_category, :only => [:fetch_subcategories]
  before_filter :load_images, :only => [:show, :new]
  
  protected
  def load_snippets
    @snippets = Snippet.all
  end

  def load_snippet
    @snippet = Snippet.find(params[:id])
  end

  def load_new_snippet
    @snippet = Snippet.new(params[:snippet])
  end

  def load_categories
    @categories = Category.all
  end

  def load_category
    @category = Category.find(params[:category_id])
  end

  def load_images
    @images = @snippet.images
  end

  public
  def index
  end

  def new
  end

  def create
    if params[:image].present?
      @snippet.images.build(:image_file => params[:image])
    end

    if @snippet.save
      flash[:notice] = "Snippet created successfully."
      redirect_to @snippet
    else
      flash.now[:error] = "There was a problem saving the snippet."
      render :action => :new
    end
  end

  def fetch_subcategories
    @subcategories = @category.subcategories
    render :layout => false
  end

  def edit
  end

  def update
    if params[:image].present?
      @snippet.images.build(:image_file => params[:image])
    end
    if @snippet.update_attributes(params[:snippet])
      flash[:notice] = "The snippet was successfully edited."
      redirect_to :action => 'show', :id => @snippet
    else
      flash.now[:notice] = "There was a problem updating the snippet."
      render :action => 'edit'
    end
  end

  def destroy_image
    if params[:image_id].present?
      @image = Image.find(params[:image_id])
    end
    if @image.destroy
      flash[:notice] = "The image was deleted."
      redirect_to :action => 'show', :id => @snippet
    else
      flash.now[:error] = "There was a problem deleting the image."
      render :action => 'show'
    end
  end

  def destroy
    if @snippet.destroy
      flash[:notice] = "The snippet was deleted."
      redirect_to snippets_path
    else
      flash.now[:error] = "There was a problem deleting the snippet, dummy."
      render :action => 'show'
    end
  end

  def show
  end
end
