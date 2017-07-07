class WelcomeController < ApplicationController
  def index
    @plans = Braintree::Plan.all
  end
end
