Spree::ReimbursementMailer.class_eval do
  private
  def all_recipients
    @reimbursement.order.all_recipients
  end
end
