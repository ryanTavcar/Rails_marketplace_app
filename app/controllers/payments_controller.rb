class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]

    def webhook
        payment_intent_id = params[:data][:object][:payment_intent]
        pp params[:data][:object][:charges]
        payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
        pp payment.charges
        product_id = payment.metadata.product_id
        buyer_id = payment.metadata.user_id

        puts "product: #{payment.metadata.product_id}"
        puts "Buyer: #{payment.metadata.user_id}"
        product = Product.find(product_id)
        product.purchased = true
        product.save
        Order.create(user_id: buyer_id, product_id: product_id, payment_intent: payment_intent_id, receipt_url: payment.charges.data[0].receipt_url)
    end
end
