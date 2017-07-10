class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
    @subscription.plan_id =params[:plan_id]
    @plans = Braintree::Plan.all
    @plans.each do |plan|
      if plan.id == params[:plan_id]
        @plan = plan
      end
    end
  end
  def create
    if current_user.customer_id.nil?
      result = Braintree::Customer.create(
        :email => current_user.email,
        :payment_method_nonce => params[:payment_method_nonce]
      )
      customer = result.customer
      if result.success?
        current_user.update(:customer_id => customer.id)
      end
    end

    result = Braintree::Subscription.create(
      :payment_method_nonce => params[:subscription][:payment_method_token],
      :plan_id => params[:subscription][:plan_id]
    )
    # current_user.update(braintree_subscription_id: result.subscription.id)

    if result.success?
      params[:subscription][:user] = current_user
      params[:subscription][:braintree_subscription_id] = result.subscription.id
      @subscription = Subscription.new(subscription_params)
      if @subscription.save
        redirect_to root_path, :notice => "You have been subscribed"
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

   def subscription_params
     params.require(:subscription).permit(:user, :payment_method_token,:braintree_subscription_id, :plan_id)
   end
end
