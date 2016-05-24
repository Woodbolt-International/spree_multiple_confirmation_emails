module AddAllRecipients
  def mail(headers={}, &block)
    headers[:to] = @order.all_recipients
    super
  end
end

Spree::BaseMailer.class_eval do
  prepend AddAllRecipients
end
