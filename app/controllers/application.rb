# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '9d187a03337ce947eda033cf360d6a0e'
  
  ALPHABET = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :get_user
  
  include AuthenticatedSystem

  private
    def get_user
      if logged_in? then @user = current_user end
    end

end
