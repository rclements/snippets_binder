class CodeBlocksController < ApplicationController
  before_filter :ensure_snippet_id, :only => [:new, :create]
  before_filter :load_new_code_block, :only => [:new, :create]
  before_filter :load_code_block, :only => [:edit, :update, :destroy]
  before_filter :load_code_types, :only => [:new, :create, :edit, :update]

  protected
  def ensure_snippet_id
    unless params[:snippet_id]
      flash[:error] = "You shouldn't be here without a snippet id."
      redirect_to "/" and return
    end
  end

  def load_new_code_block
    @code_block = CodeBlock.new(params[:code_block])
    @code_block.snippet_id = params[:snippet_id]
  end

  def load_code_block
    @code_block = CodeBlock.find(params[:id])
  end

  def load_code_types
    @code_types = CodeBlock::CODE_TYPES
  end

  public
  def new
  end

  def create
    if @code_block.save
      flash[:notice] = "Code block was saved successfully."
      redirect_to @code_block.snippet
    else
      flash.now[:error] = "There was a problem saving the code block."
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @code_block.update_attributes(params[:code_block])
      flash[:notice] = "Code block has been updated successfully."
      redirect_to @code_block.snippet
    else
      flash.now[:error] = "There was a problem updating the code block."
      render :action => 'edit'
    end
  end

  def destroy
    @snippet = @code_block.snippet
    if @code_block.destroy
      flash[:notice] = "Code block deleted successfully."
      redirect_to @snippet
    else
      flash[:error] = "There was a problem deleting that code block."
      redirect_to "/"
    end
  end
end
