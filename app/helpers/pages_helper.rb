module PagesHelper
  
  # Pull the application name set in config/application.rb
  # Call with appname in page layouts like <%= appname %>
  def appname
    @appname = Rails.application.appname
  end

end
