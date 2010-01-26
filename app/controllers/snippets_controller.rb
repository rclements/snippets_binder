class SnippetsController < ApplicationController
  before_filter :load_snippets, :only => [:index]
  before_filter :load_snippet, :only => [:show, :edit, :update, :destroy]

  protected
  def load_snippets
    @snippets = Snippet.all
  end

  def load_snippet
    @snippet = Snippet.find(params[:id])
  end

  public
  def index
  end

  def create
    if @snippet.save
      flash[:notice] = "Snippet created successfully."
    else
      flash.now[:error] = "There was a problem saving the snippet."
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @snippet.update_attributes(params[:snippet])
      flash[:notice] = "The snippet was successfully edited."
      redirect_to :action => 'show', :id => @snippet
    end
  end

  def destroy
    if @snippet.destroy
      flash[:notice] = "The snippet was deleted."
      redirect to '/'
    else
      flash.now[:error] = "There was a problem deleting the snippet, dummy."
      render :aciton => 'show'
    end
  end

  def show
  end
end
