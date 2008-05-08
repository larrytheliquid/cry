module LispMode
  def cry_mode
    LispMode
  end
  
  def e(*args)
    q(*args).evaluate
  end
  
  def q(*args)
    ParseTree.new(*args)
  end
end