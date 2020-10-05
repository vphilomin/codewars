require 'values'

Rank = Value.new(:value)

def Rank(value)
  case value
  when Rank then value
  else
    value = Integer(value)
    Rank.new(value)
  end
end
