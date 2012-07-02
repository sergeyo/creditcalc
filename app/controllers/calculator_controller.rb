class CalculatorController < ApplicationController
  def show
    @credit = Credit.new
    if params[:credit]
      @credit.amount = params[:credit][:amount]
      @credit.interest = params[:credit][:interest]
      @credit.init params[:credit][:type], params[:credit][:months], params[:credit][:pay_monthly]
    else
      @credit.amount = 600000
      @credit.interest = 11
      @credit.init 0, 36, 20000
    end
  end
end
