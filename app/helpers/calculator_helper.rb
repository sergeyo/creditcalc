module CalculatorHelper
  def int_to_s_or_empty(i, str = "")
    if i > 0 then
      i.to_s + str
    else
      ""
    end
  end
end
