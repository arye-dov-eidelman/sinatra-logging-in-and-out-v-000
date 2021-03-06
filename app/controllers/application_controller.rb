require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    if Helpers.log_in(params[:username], params[:password], session)
      redirect '/account'
    else
      erb :error
    end
  end

  get '/account' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    Helpers.log_out(session)
    redirect '/'
  end


end

