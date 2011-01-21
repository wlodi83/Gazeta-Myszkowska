class SitemapController < ApplicationController
  def sitemap
    @pages = Homepage.find_for_sitemap
    headers["Ostatnio-Modyfikowane"] = @pages[0].updated_at.httpdate if @pages[0]
    render :layout => false
  end
end
