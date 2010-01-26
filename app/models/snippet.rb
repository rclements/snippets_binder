class Snippet < ActiveRecord::Base
  has_many :images
  validates_presence_of :name

  def to_s
    name
  end
end
