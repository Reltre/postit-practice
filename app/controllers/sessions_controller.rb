class SessionsController < ApplicationController
  #before_action :send_pin, only: [:pin]

  def new; end

  def create
    binding.pry
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.using_two_auth?
        user.generate_pin!
        session[:user_id] = user.id
        render :pin
      else
        log_in_user(user, "Welcome #{user.username}")
      end
    else
      flash.now[:error] = "You're username or password was not valid."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to :root
  end

  def pin
    #handle checks for correct pin.
    #If correct call log_in_user
    #otherwise flash an error and render pin page.
    if request.post?
      if params[:pin] == current_user.pin
        current_user.remove_pin!
        log_in_user(current_user, "Welcome #{current_user.username}")
      else
        flash.now[:error] = "You must enter a valid pin."
        render :pin
      end
    end
  end

#Twilio additional functionality
=begin
  def send_pin
    account_sid = 'AC710c19911390d0819a43e0e0de465f3c'
    auth_token = '0a547c60f38cb46357c3f41b339339f4'
    msg = "Please enter this pin to continue log in, #{current_user.pin}"
    # set up a client to talk to the Twilio REST API
    client = Twilio::REST::Client.new(account_sid, auth_token)
    client.account.messages.create({from: 14157234000, to: "client number here"}, body: msg})
  end
=end
end
