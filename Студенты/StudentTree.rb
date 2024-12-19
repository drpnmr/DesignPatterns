require './Student.rb'

class StudentTree
    include Enumerable
  
    attr_reader :root
  
    def initialize
      @root = nil
    end
  
    class Node
      attr_accessor :value, :left, :right
  
      def initialize(value)
        @value = value
        @left = nil
        @right = nil
      end
    end
  
    def add(value)
      node = Node.new(value)
      if @root.nil?
        @root = node
      else
        add_to_node(@root, node)
      end
    end


    def add_to_node(root, node)
      if root.nil?
        return node
      end      
      if node.value < root.value
        root.left = add_to_node(root.left, node)
      else
        root.right = add_to_node(root.right, node)
      end
  
      root
    end
  
    def each(&block)
      traverse(@root, &block)
    end
  
    def traverse(node, &block)
      return if node.nil?
  
      traverse(node.left, &block)
      block.call(node.value)
      traverse(node.right, &block)
    end
end