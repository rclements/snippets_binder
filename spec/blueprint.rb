blueprint :snippet do
  Snippet.create!(:name => "this is a snippet", :description => "seriously.  a snippet.")
end
blueprint :image do
  Image.create!(:id => 1)
end
