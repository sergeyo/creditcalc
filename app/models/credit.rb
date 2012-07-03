class Credit < ActiveRecord::Base

  attr_accessor :amount, :interest, :type, :months, :pay_monthly

  def init(type, pmonths, ppay_monthly)
    self.amount = self.amount.to_i
    self.interest = self.interest.to_f
    self.type = type.to_i
    case type.to_i
      when 0 then
        self.months = pmonths.to_i
        self.pay_monthly = (amount * (get_month_interest * (1 + get_month_interest) ** months) / ((1 + get_month_interest) ** months - 1)).ceil
      when 1 then
        self.pay_monthly = ppay_monthly.to_i
        rest = self.amount
        count_months = 0
        while rest > 0 do
          count_months += 1
          rest -= self.pay_monthly - (rest * get_month_interest)
        end
        self.months = count_months
      when 2 then
        self.months = pmonths.to_i
        self.pay_monthly = (self.amount.to_f / pmonths.to_f).ceil
    end
  end

  def get_payment_table
    pays = []
    return [] unless self.amount && self.pay_monthly && self.months
    rest = self.amount
    if type < 2 then
      (1..months).each do |i|
        this_pay_percent = rest * get_month_interest()
        this_pay_body = pay_monthly - this_pay_percent
        this_pay_body = rest if this_pay_body > rest
        pays.push [i, this_pay_percent, this_pay_body, rest -= this_pay_body]
      end
    else
      (1..months).each do |i|
        pays.push [i, rest * get_month_interest, self.pay_monthly, rest -= self.pay_monthly]
      end
    end
    pays
  end

  def get_total_interest
    total_interest = 0
    return 0 unless self.amount && self.pay_monthly
    rest = self.amount
    while rest > 0
      this_interest = rest * get_month_interest
      total_interest += this_interest
      if type < 2 then
        rest -= self.pay_monthly - this_interest
      else
        rest -= self.pay_monthly
      end
    end
    total_interest
  end

  private

  def get_month_interest
    @month_interest ||= interest / 12.0 / 100.0
  end
end
