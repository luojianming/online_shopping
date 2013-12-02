#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "cortechino.com@gmail.com"

  def new_order_email(order)
    @order = order
    @url = "http://www.cortechino.com/orders/"+@order.id.to_s
    mail(:to => "xiaoluo0527@126.com", :subject => "有新的订单")
  end
end
