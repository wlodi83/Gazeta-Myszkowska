class AssetsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def manage
    @assets = "#{params[:media]}".classify.constantize.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
    render :update do |page|
      page.replace_html :dynamic_images_list, :partial => 'show_asset_list'
    end
  end
  


  def create
    @asset = "#{params[:media]}".classify.constantize.new(params[params[:media]])
    
    if @asset.save
      GC.start
      responds_to_parent do
        render :update do |page|
          page << "upload_callback();"
        end
      end
    else
      responds_to_parent do
        render :update do |page|
          page.alert('Sorry, there was an error uploading the photo.')
        end
      end
    end
  end
end
