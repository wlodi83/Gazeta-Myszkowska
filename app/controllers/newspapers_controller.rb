class NewspapersController < ApplicationController
  
  before_filter :check_administrator_role,
                :except => [:show]
  
  # GET /newspapers
  # GET /newspapers.xml
  def index
    @newspapers = Newspaper.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @newspapers }
    end
  end

  # GET /newspapers/1
  # GET /newspapers/1.xml
  def show
    @newspaper = Newspaper.find(params[:id])
    if @newspaper.has_map?
    loc = @newspaper.location
    @map = GMap.new("map_div")
    @map.control_init(:large_map => true,
    :map_type => true)
    @map.center_zoom_init(loc,@newspaper.zoom)
    @map.overlay_init(GMarker.new(loc,
      :title => @newspaper.name,
      :info_window => @newspaper.address))
  end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @newspaper }
    end
  end

  # GET /newspapers/new
  # GET /newspapers/new.xml
  def new
    @newspaper = Newspaper.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @newspaper }
    end
  end

  # GET /newspapers/1/edit
  def edit
    @newspaper = Newspaper.find(params[:id])
    @map = GMap.new("map_div")
    loc = @newspaper.location
    @map.control_init(:large_map => true,
      :map_type => true)
    @map.center_zoom_init(loc, @newspaper.zoom)
    marker = GMarker.new(loc,:draggable => true)
    @map.overlay_global_init(marker,"marker")
    marker.on_dragend("gmap_update_position")
    @map.on_zoomend("gmap_update_zoom")
  end

  # POST /newspapers
  # POST /newspapers.xml
  def create
    @newspaper = Newspaper.new(params[:newspaper])

    respond_to do |format|
      if @newspaper.save
        flash[:notice] = 'Newspaper was successfully created.'
        format.html { redirect_to(@newspaper) }
        format.xml  { render :xml => @newspaper, :status => :created, :location => @newspaper }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @newspaper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /newspapers/1
  # PUT /newspapers/1.xml
  def update
    @newspaper = Newspaper.find(params[:id])

    respond_to do |format|
      if @newspaper.update_attributes(params[:newspaper])
        flash[:notice] = 'Newspaper was successfully updated.'
        format.html { redirect_to(@newspaper) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @newspaper.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /newspapers/1
  # DELETE /newspapers/1.xml
  def destroy
    @newspaper = Newspaper.find(params[:id])
    @newspaper.destroy

    respond_to do |format|
      format.html { redirect_to(newspapers_url) }
      format.xml  { head :ok }
    end
  end
end
