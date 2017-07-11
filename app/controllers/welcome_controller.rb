class WelcomeController < ApplicationController
  def index
    @plans = Braintree::Plan.all
    @subscription = Subscription.new
  end
end
