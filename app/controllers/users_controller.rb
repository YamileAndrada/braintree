class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_braintree_customer(@user)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:street, :city, :postal_code, :state, :country_code)
  end

  def create_braintree_customer(user)
    #A billing address associated with a specific credit card. The maximum number of addresses per customer is 50.

    result = Braintree::Customer.create(
      :email => user[:email],
      :first_name => user[:first_name],
      :last_name => user[:last_name],
      #:phone
      #:fax
      :credit_card => {
        :billing_address => {
          :first_name => user[:first_name],
          :last_name => user[:last_name],
          :country_name => "Argentina",
          # :company => "Braintree",
          :street_address => "123 Address",
          :locality => "City",
          # :region => "State",
          # :postal_code => "12345"
        },
        :cvv => '123',
        :expiration_month => 12,
        :expiration_year => 22,
        :number => '4111111111111111'
      }
    )
    if result.success?
      user.update_attribute(:customer_id, result.customer.id)
    else
      logger.error "Could not create braintree customer for email #{user.email}, because of #{result.errors.inspect}"
    end
  end
end