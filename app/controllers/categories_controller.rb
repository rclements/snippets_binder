class CategoriesController < ApplicationController
  before_filter :load_categories, :only => [:index]
  before_filter :load_category, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_category, :only => [:new, :create]
  before_filter :load_subcategories, :only => [:show]
  before_filter :load_snippets, :only => [:show]
  
  protected
  def load_categories
    @categories = Category.all
  end

  def load_subcategories
    @subcategories = @category.subcategories
  end

  def load_category
    @category = Category.find(params[:id])
  end

  def load_new_category
    @category = Category.new(params[:category])
  end

  def load_snippets
    @snippets = Snippet.all
  end

  public

  def index
  end

  def new
  end

  def create
    if @category.save
      flash[:notice] = "Category created successfully."
      redirect_to @category
    else
      flash.now[:error] = "There was a problem saving the category."
      render :action => :new
    end
  end
  
  def edit
  end

  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "The category was successfully edited."
      redirect_to :action => 'show', :id => @category
    else
      flash.now[:notice] = "There was a problem updating the category."
      render :action => 'edit'
    end
  end


  def destroy
    if @category.destroy
      flash[:notice] = "The category was deleted."
      redirect_to categories_path
    else
      flash.now[:error] = "There was a problem deleting the category."
      render :action => 'show'
    end
  end

  def show
  end
end


