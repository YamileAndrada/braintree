class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def paypal_webhook
    webhook_notification = Braintree::WebhookNotification.parse(
      request.params["bt_signature"],
      request.params["bt_payload"]
    )
    logger.info webhook_notification.kind # "subscription_went_past_due"
    logger.info webhook_notification.timestamp # "Sun Jan 1 00:00:00 UTC 2012"
    logger.info webhook_notification.subscription.id
    return 200
  end
end
