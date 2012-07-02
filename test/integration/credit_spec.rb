require File.expand_path('../../test_helper', __FILE__)

describe "Calculating various credit types" do
  let (:credit) { Credit.new }
  it "should calculate right annual by months given" do
    credit.update_attributes amount: 600000, interest: 10
    credit.init 0, 36, 0
    credit.get_payment_table.count.should == 36
    credit.get_total_interest.should = 100000
  end
  it "should calculate right annual by pay_monthly given" do
    credit.update_attributes amount: 600000, interest: 10
    credit.init 1, 0, 20000
    credit.get_payment_table.count.should == 35
    credit.get_total_interest.should = 90000
  end
  it "should calculate right differential by months given" do
    credit.update_attributes amount: 600000, interest: 10
    credit.init 2, 36, 0
    credit.get_payment_table.count.should == 36
    credit.get_total_interest.should = 80000
  end
end