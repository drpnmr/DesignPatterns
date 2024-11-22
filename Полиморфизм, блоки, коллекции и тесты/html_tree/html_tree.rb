require './html_tag.rb'
class HtmlTree
  include Enumerable

  attr_accessor :root

  def initialize(root_tag)
    @root = root_tag
  end
  

  def add_tag(parent_tag, child_tag)
    parent_tag.children << child_tag
  end
  
  def each
    dfs.each do |element| 
      yield element
    end
  end

  def dfs
    stack = [root]
    until stack.empty?
      current = stack.pop
      yield(current)
      current.children.reverse.each { |child| stack.push(child) }
    end
  end

  def bfs
    queue = [root]
    until queue.empty?
      current = queue.shift
      yield(current)
      current.children.each { |child| queue.push(child) }
    end
  end
  
end