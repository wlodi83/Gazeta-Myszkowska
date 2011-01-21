# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  include LoginSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => 'afb84dea7f8e4fd87b681bc8afb90226'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  before_filter :sanitize_params

def sanitize_params
  @params = walk_hash(@params) if @params and !site_owner?
end

def walk_hash(hash)
    hash.keys.each do |key|
  if hash[key].is_a? String
    hash[key] = white_list(hash[key])
  elsif hash[key].is_a? Hash
    hash[key] = walk_hash(hash[key])
  elsif hash[key].is_a? Array
    hash[key] = walk_array(hash[key])
  end
end
    hash
end

def walk_array(array)
  array.each_with_index do |el,i|
  if el.is_a? String
    array[i] = white_list(el)
  elsif el.is_a? Hash
    array[i] = walk_hash(el)
  elsif el.is_a? Array
    array[i] = walk_array(el)
  end
end
  array
end

end
