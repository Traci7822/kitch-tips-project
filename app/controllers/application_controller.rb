require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "kitchtipsaregreat"
    use Rack::Flash
  end

  include Validify::InstanceMethods

  get '/' do
    @sorted_tips = []
    @recent_tips = []
    Tip.all.each do |tip|
      @sorted_tips << tip.created_at
    end
    @sorted_tips.reverse[0..4].each do |time|
      @recent_tips << Tip.find_by(created_at: time)
    end
    erb :index
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    if params_blank?(params)
      flash[:message] = "Fields cannot be blank, please try again"
      redirect '/signup'
    elsif
      User.find_by(:email => params[:email])
      flash[:message] = "User with this email address already exists, try again"
      redirect '/signup'
    else
      user = User.create(name: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = user.id
      redirect "/user"
    end
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    if params_blank?(params)
      flash[:message] = "Fields cannot be blank, please try again"
      redirect "/login"
    elsif
      User.find_by(:name => params[:username]) == nil
      flash[:message] = "User not found, please try again"
      redirect "/login"
    else
      @user = User.find_by(:name => params[:username])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect "/user"
      end
    end
  end

  get '/logout' do
    session.clear
    redirect "/"
  end

  helpers do
    def current_user(session)
      User.find_by_id(session[:user_id])
    end

    def logged_in?(session)
      !!current_user(session)
    end
  end
end
