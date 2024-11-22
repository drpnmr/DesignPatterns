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

puts tree.root.to_s

puts "\nОбход в глубину:"
tree.dfs { |tag| puts tag.name }

puts "\nОбход в ширину:"
tree.bfs { |tag| puts tag.name }



  