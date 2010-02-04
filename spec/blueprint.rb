blueprint :snippet do
  Snippet.create!(:name => "this is a snippet", :description => "seriously.  a snippet.")
end
blueprint :image do
  Image.create!(:id => 1, :image_file_file_name => 'boobies.jpg')
end
blueprint :category do
  Category.create!(:name => "this is a category")
end
blueprint :subcategory do
  Subcategory.create!(:name => "this is a subcategory")
end
