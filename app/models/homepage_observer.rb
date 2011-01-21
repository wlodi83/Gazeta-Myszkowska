class HomepageObserver < ActiveRecord::Base
require 'net/http'
require 'uri'
class HomepageObserver < ActiveRecord::Observer
observe Homepage
include ActionController::UrlWriter
default_url_options[:host] = 'http://localhost:3000/'
def after_create(homepage)
Net::HTTP.get('www.google.com' ,'/ping?sitemap=' + URI.escape(sitemap_url))
end
end
end
