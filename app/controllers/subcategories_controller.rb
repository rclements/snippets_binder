class SubcategoriesController < ApplicationController
  before_filter :load_subcategory
  before_filter :load_subcategory, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_subcategory, :only => [:new, :create]

  protected
  def load_subcategories
    @subcategories = Subcategory.all
  end

  def load_subcategory
    @subcategory = Subcategory.find(params[:name])
  end

  public

  def index
  end

  def new
  end

  def create
    if @subcategory.save
      flash[:notice] = "Subcategory created successfully."
      redirect_to @subcategory
    else
      flash.now[:error] = "There was a problem saving the subcategory."
      render :action => :new
    end
  end

  def edit
  end

  def destroy
    if @subcategory.destroy
      flash[:notice] = "The subcategory was deleted."
      redirect_to subcategory_path
    else
      flash.now[:error] = "There was a problem deleting the subcategory."
      render :action => 'show'
    end

  def show
  end
end
    
