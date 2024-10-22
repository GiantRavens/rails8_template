class PagesController < ApplicationController
  
  # before_action :require_login, except: %i[home index about]
  # before_action :authenticate_user!, except: [:index, :about]
  # before_action :authenticate_user!, except: [:index, :about]
  # before_action :require_authentication, except: [:index, :about]
  # before_action :authenticate_user, except: [:index, :about]
  
  allow_unauthenticated_access(only: [:index, :about])
  
  def index
  end

  def welcome
  end

  def about
  end
end
