class CategoriesController < ApplicationController
  before_filter :load_category
  before_filter :load_category, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_category, :only => [:new, :create]

  protected
  def load_categories
    @categories = Category.all
  end

  def load_category
    @category = Category.find(params[:name])
  end

  def load_new_category
    @category = Category.new(params[:category])
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

  def destroy
    if @category.destroy
      flash[:notice] = "The category was deleted."
      redirect_to category_path
    else
      flash.now[:error] = "There was a problem deleting the category."
      render :action => 'show'
    end
  end

  def show
  end
end


