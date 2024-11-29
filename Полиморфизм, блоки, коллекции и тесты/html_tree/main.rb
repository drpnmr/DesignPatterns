require './html_tree.rb'

html_content = <<-HTML
<div class="container">
  <h1>здравствуйте</h1>
  <p class="intro">
    <span>спасите</span>
    <span>меня</span>
  </p>
  <h2 class="footer">пожалуйста</h2>
</div>
HTML

tree = HtmlTree.new(html_content)

puts tree.root
puts tree.root.tag_depth
puts tree.root.has_children?

first_tag=tree.root.children.first
puts first_tag.to_s

puts tree.select { |tag| tag.name == "span" }