module CalculatorHelper
  def int_to_s_or_empty(i, str = "")
    if i > 0 then
      i.to_s + str
    else
      ""
    end
  end

  def format_summ(sum)
    sum.to_s.reverse.scan(/\d{3}|\d{2}|\d{1}/).join(" ").reverse
  end
end
