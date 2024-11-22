class HtmlTag
    attr_accessor :name, :attributes, :children, :content
  
    def initialize(name, attributes = {}, content = nil)
      @name = name
      @attributes = attributes
      @content = content
      @children = []
    end

    def to_s
      attributes_string = attributes.map { |k, v| "#{k}=\"#{v}\"" }.join(" ")
      start_tag = attributes_string.empty? ? "<#{name}>" : "<#{name} #{attributes_string}>"
      end_tag = "</#{name}>"
    
      "#{start_tag}#{content}#{children.map(&:to_s).join}#{end_tag}\n"
    end
    
    def tag_depth
      children.map(&:tag_depth).max.to_i + 1
    end
  
    def has_children?
      !children.empty?
    end
    
end