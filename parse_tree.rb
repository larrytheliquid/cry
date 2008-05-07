# make an "e" method to evaluate a parse tree
# make a "q" method to quote a parse tree
# make a "p" method to create a new parse tree

class ParseTree
  def initialize(nodes)
    @nodes = nodes
  end  
  attr_accessor :nodes
  def evaluate(array = nodes)
    node_method = array.first.keys.first.to_sym
    node_object = if array.first.values.first.is_a?(Array)
      evaluate(array.first.values.first)
    else
      array.first.values.first
    end
    node_arguments = []
    array.rest.each do |element|
      node_arguments << if element.is_a?(Array)
        evaluate(element)          
      else
        element
      end
    end
    node_object.send( *([node_method] + node_arguments) )
  end
end

class Array
  def rest
    self[1..size]
  end
end