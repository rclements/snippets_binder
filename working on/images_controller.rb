class ImagesController < ApplicationController
  before_filter :load_images, :only => [:index]
  before_filter :load_new_image, :only => [:new, :create]
  before_filter :load_image, :only => [:show, :edit, :update, :destroy]

  protected
  def load_images
    @images = Image.all
  end

  def load_new_image
    @image = Image.new(params[:image])
  end

 
  def load_image
    @image = Image.find(params[:id])
  end

  public
  def index
  end

  def new
  end

  def create
    if @image.save
      flash[:notice] = "Image created successfully."
      redirect_to image_path(@image)
    else
      flash.now[:error] = "There was a problem saving the image."
      render :action => :new
    end
  end

  def save_upload(upload)
    self.original_filename = sanitize_file_name(upload.original_filename)
    self.new_filename = unique_filename
    File.open(absolute_path, "wb") { |f| f.write(upload.read) }
  end

  def save_file
    if params[:image] != nil
      image = Image.new
      image.save_upload(params[:image])
    end
  end

  def edit
  end

  def update
    if @image.update_attributes(params[:image])
      flash[:notice] = "The image was successfully edited."
      redirect_to :action => 'show', :id => @image
    end
  end

  def destroy
    if @image.destroy
      flash[:notice] = "The image was deleted."
      redirect_to images_path
    else
      flash.now[:error] = "There was a problem deleting the image, dummy."
      render :action => 'show'
    end
  end

  def show
  end

  private
    def absolute_path
      File.join(Rails.root, 'public/system/image_files', self.new_filename)
    end

    def sanitize_filename(filename)
      File.basename(filename).gsub(/[^\w\.\_]/,'_')
    end

    def unique_filename
      Time.now.strftime("%m%d%Y%H%M%S").to_s + "-#{self.original_filename}"
    end
end
