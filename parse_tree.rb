class ParseTree < Array
  def initialize(*args)
    super(args.to_ary)
  end  
  alias_method :nodes, :to_ary
  
  def evaluate
    node_object.send( *([node_method] + node_arguments) )
  end
  
  def node_method
    self.first.to_sym unless empty?
  end
  
  def node_object
    self[1].is_a?(ParseTree) ? self[1].evaluate : self[1] unless size < 2
  end
  
  def node_arguments
    unless size < 2
      self[2..size].map{|argument| argument.is_a?(ParseTree) ? argument.evaluate : argument }
    else
      []
    end    
  end  
end