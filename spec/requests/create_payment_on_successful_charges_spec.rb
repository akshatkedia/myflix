require 'spec_helper'

RSpec.describe "CreatePaymentOnSuccessfulCharges", type: :request do
  let(:event_data) do
    {
      "id" => "evt_1Cj4uNAma8RRGxBX8DNaj62H",
      "object" => "event",
      "api_version" => "2018-05-21",
      "created" => 1530449043,
      "data" => {
        "object" => {
          "id" => "ch_1Cj4uMAma8RRGxBXji897jDG",
          "object" => "charge",
          "amount" => 999,
          "amount_refunded" => 0,
          "application" => nil,
          "application_fee" => nil,
          "balance_transaction" => "txn_1Cj4uMAma8RRGxBXY90JZLRW",
          "captured" => true,
          "created" => 1530449042,
          "currency" => "usd",
          "customer" => "cus_D9NfeyKYAL0zpx",
          "description" => nil,
          "destination" => nil,
          "dispute" => nil,
          "failure_code" => nil,
          "failure_message" => nil,
          "fraud_details" => {
          },
          "invoice" => "in_1Cj4uMAma8RRGxBXmOIf03n1",
          "livemode" => false,
          "metadata" => {
          },
          "on_behalf_of" => nil,
          "order" => nil,
          "outcome" => {
            "network_status" => "approved_by_network",
            "reason" => nil,
            "risk_level" => "normal",
            "seller_message" => "Payment complete.",
            "type" => "authorized"
          },
          "paid" => true,
          "receipt_email" => nil,
          "receipt_number" => nil,
          "refunded" => false,
          "refunds" => {
            "object" => "list",
            "data" => [
            ],
            "has_more" => false,
            "total_count" => 0,
            "url" => "/v1/charges/ch_1Cj4uMAma8RRGxBXji897jDG/refunds"
          },
          "review" => nil,
          "shipping" => nil,
          "source" => {
            "id" => "card_1Cj4uJAma8RRGxBXocESJ8bE",
            "object" => "card",
            "address_city" => nil,
            "address_country" => nil,
            "address_line1" => nil,
            "address_line1_check" => nil,
            "address_line2" => nil,
            "address_state" => nil,
            "address_zip" => nil,
            "address_zip_check" => nil,
            "brand" => "Visa",
            "country" => "US",
            "customer" => "cus_D9NfeyKYAL0zpx",
            "cvc_check" => "pass",
            "dynamic_last4" => nil,
            "exp_month" => 7,
            "exp_year" => 2021,
            "fingerprint" => "kPZZo9yIJLGbZr5v",
            "funding" => "credit",
            "last4" => "4242",
            "metadata" => {
            },
            "name" => nil,
            "tokenization_method" => nil
          },
          "source_transfer" => nil,
          "statement_descriptor" => nil,
          "status" => "succeeded",
          "transfer_group" => nil
        }
      },
      "livemode" => false,
      "pending_webhooks" => 1,
      "request" => {
        "id" => "req_L8h1lER5jDsL7L",
        "idempotency_key" => nil
      },
      "type" => "charge.succeeded"
    }
  end

  it "creates a payment with the  webhook from stripe for charge succeeded", :vcr do
    post "/stripe_events", params: event_data
    expect(Payment.count).to eq(1)
  end
end
