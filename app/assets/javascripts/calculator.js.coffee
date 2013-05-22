# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

disable_element = (id) ->
  $(id).attr enabled, false

enable_element = (id) ->
  $(id).attr enabled, true

set_controls_credittype = (type) ->
  $('#sss').text type
  switch type
    when "annual_by_payment"
      disable_element('#credit_months')
      enable_element('#credit_pay_monthly')
      $('#credit_type').attr value, 0
    when "annual_by_period"
      disable_element('#credit_pay_monthly')
      enable_element('#credit_months')
      $('#credit_type').attr value, 1
    when "differential"
      disable_element('#credit_pay_monthly')
      enable_element('#credit_months')
      $('#credit_type').attr value, 2
  false
