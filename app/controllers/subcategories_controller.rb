class SubcategoriesController < ApplicationController
  before_filter :load_subcategories, :only => [:index, :show]
  before_filter :load_subcategory, :only => [:show, :edit, :update, :destroy]
  before_filter :load_new_subcategory, :only => [:new, :create]
  before_filter :load_snippets, :only => [:show]

  protected
  def load_subcategories
    @subcategories = Subcategory.all
  end

  def load_subcategory
    @subcategory = Subcategory.find(params[:id])
  end

  def load_new_subcategory
    @subcategory = Subcategory.new(params[:subcategory]) 
    @subcategory.category_id = params[:category_id]
  end

  def load_snippets
    @snippets = @subcategory.snippets.all
  end

  public

  def index
  end

  def new
  end

  def create
    if @subcategory.save
      flash[:notice] = "Subcategory created successfully."
      redirect_to @subcategory.category
    else
      flash.now[:error] = "There was a problem saving the subcategory."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if  @subcategory.update_attributes(params[:subcategory])
      flash[:notice] = "The subcategory was successfully edited."
      redirect_to :action => 'show', :id => @subcategory
    else
     flash.now[:notice] = "There was a problem updating the subcategory."
     render :action => 'edit'
    end
  end


  def destroy
    @category = @subcategory.category
    if @subcategory.destroy
      flash[:notice] = "The subcategory was deleted."
      redirect_to @category
    else
      flash.now[:error] = "There was a problem deleting the subcategory."
      render :action => 'show'
    end
  end

  def show
  end
end
    
