Spree::OrderMailer.class_eval do
  private
  def all_recipients
    @order.all_recipients
  end
end
