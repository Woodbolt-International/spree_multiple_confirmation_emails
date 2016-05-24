require 'spec_helper'
require 'email_spec'

describe Spree::OrderMailer, :type => :mailer do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  before { create(:store) }

  let(:order) do
    order = stub_model(Spree::Order)
    order.email = Faker::Internet.email
    product = stub_model(Spree::Product, :name => %Q{The "BEST" product})
    variant = stub_model(Spree::Variant, :product => product)
    price = stub_model(Spree::Price, :variant => variant, :amount => 5.00)
    line_item = stub_model(Spree::LineItem, :variant => variant, :order => order, :quantity => 1, :price => 4.99)
    allow(variant).to receive_messages(:default_price => price)
    allow(order).to receive_messages(:line_items => [line_item])
    order
  end

  context "when order does have multiple recipients" do
    before do
      order.additional_confirmation_emails = 3.times.map { Faker::Internet.email }.join(",")
    end

    it "sends confirm email to all recipients" do
      message = Spree::OrderMailer.confirm_email(order)
      expect(message.to).to eq(order.all_recipients.split(","))
    end

    it "sends cancel email to all recipients" do
      message = Spree::OrderMailer.cancel_email(order)
      expect(message.to).to eq(order.all_recipients.split(","))
    end
  end

  context "when order does not have multiple recipients" do
    before do
      order.additional_confirmation_emails = ""
    end

    it "sends confirm email to all recipients" do
      message = Spree::OrderMailer.confirm_email(order)
      expect(message.to).to eq([order.email])
    end

    it "sends cancel email to all recipients" do
      message = Spree::OrderMailer.cancel_email(order)
      expect(message.to).to eq([order.email])
    end
  end
end
