# encoding: utf-8
module BillsHelper
  def show_rmb(num)
    number_to_currency(num, :precision => 1, :unit=>"￥")
  end
end
