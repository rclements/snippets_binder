class Snippet < ActiveRecord::Base
  has_many :images
  validates_presence_of :name

  def to_s
    name
  end
# faking acts_as_paranoid since its no longer supported
# note: this breaks before_delete call backs, but since we aren't using them...
  default_scope :conditions => {:deleted_at => nil}
    def destroy
      self.update_attribute(:deleted_at, Time.zone.now)
    end
         
    def deleted?
      !!self.deleted_at
  end
end
