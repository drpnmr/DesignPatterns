require './html_tree.rb'

root = HtmlTag.new("html")
tree = HtmlTree.new(root)

head = HtmlTag.new("head")
body = HtmlTag.new("body")
title = HtmlTag.new("title", {}, ":(")
h1 = HtmlTag.new("h1", { class: "SuperMegaClass" }, "Hello")
p = HtmlTag.new("p", {}, ":)")

tree.add_tag(root, head)
tree.add_tag(root, body)
tree.add_tag(head, title)
tree.add_tag(body, h1)
tree.add_tag(body, p)

puts tree.root.to_s

puts "\nОбход в глубину:"
tree.dfs { |tag| puts tag.name }

puts "\nОбход в ширину:"
tree.bfs { |tag| puts tag.name }
  