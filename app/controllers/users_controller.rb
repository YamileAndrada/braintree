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
    #no pude crear el customer con un billing address
    result = Braintree::Customer.create(
      :email => user[:email],
      :first_name => user[:first_name],
      :last_name => user[:last_name]
    )
    if result.success?
      user.update_attribute(:customer_id, result.customer.id)
    else
      logger.error "Could not create braintree customer for email #{user.email}, because of #{results.errors.inspect}"
    end
  end
end