class OrderMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(order)
    @order = order
    @order_lines = @order.line_items

    mail(to: @order.email, subject: "Receipt for Order ##{@order.id}")
  end
end



