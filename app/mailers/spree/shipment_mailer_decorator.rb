Spree::ShipmentMailer.class_eval do
  private
  def all_recipients
    @shipment.order.all_recipients
  end
end
