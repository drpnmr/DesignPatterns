require './Student.rb'
class StudentTree
    include Enumerable
  
    attr_reader :root
  
    def initialize
      @root = nil
    end
  
    class Node
      attr_accessor :student, :left, :right
  
      def initialize(student)
        @student = student
        @left = nil
        @right = nil
      end
    end
  
    def add(student)
      @root = add_to_node(@root, student)
    end
  
    def add_to_node(node, student)
      return Node.new(student) if node.nil?
  
      if student.birth_date < node.student.birth_date
        node.left = add_to_node(node.left, student)
      else
        node.right = add_to_node(node.right, student)
      end
  
      node
    end
  
    def each(&block)
      traverse(@root, &block)
    end
  
    def traverse(node, &block)
      return if node.nil?
  
      traverse(node.left, &block)
      yield(node.student)
      traverse(node.right, &block)
    end
  end
  