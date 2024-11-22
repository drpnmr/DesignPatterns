require './html_tag.rb'
class HtmlTree
  include Enumerable

  attr_accessor :root

  TAG_REGEX = /<([a-zA-Z0-9]+)(.*?)>(.*?)<\/\1>/m

  def initialize(html_content)
    @root = parse_html(html_content)
  end

  def parse_html(html_content, parent = nil)
    return nil if html_content.strip.empty?

    matches = TAG_REGEX.match(html_content)
    name = matches[1]
    attributes = parse_attributes(matches[2])
    content = matches[3]

    tag = HtmlTag.new(name, attributes)
    content.scan(TAG_REGEX) do |child_tag|
      child_html = "<#{child_tag[0]}#{child_tag[1]}>#{child_tag[2]}</#{child_tag[0]}>"
      tag.children << parse_html(child_html)
    end

    plain_text = content.gsub(TAG_REGEX, "").strip
    tag.content = plain_text unless plain_text.empty?

    tag
  end

  def parse_attributes(attributes_string)
    attributes_string.scan(/([a-zA-Z0-9_-]+)="(.*?)"/).to_h
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