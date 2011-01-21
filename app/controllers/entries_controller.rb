class EntriesController < ApplicationController
  before_filter :login_required, :except => [:index, :show]
  # GET /entries
  # GET /entries.xml
  def index
    @user = User.find(params[:user_id])
    @entry_pages = Paginator.new(self, @user.entries_count,10,params[:page])  
    @entries = @user.entries.find(:all, :order => 'created_at DESC',
                                        :limit => @entry_pages.items_per_page,
                                        :offset => @entry_pages.current.offset)
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find_by_id_and_user_id(params[:id],params[:user_id],
                                          :include => [:user, [:comments => :user]])

  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    @entry = @logged_in_user.entries.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])
    
    if logged_in_user.entries << @entry
      flash[:notice] = 'Entry was successfully created.'
      redirect_to entry_path(:user_id => logged_in_user, 
                                         :id => @entry)
   
    else
      render :action => "new"
    end
  end
  

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
  @entry = @logged_in_user.entries.find(params[:id])
  if @entry.update_attributes(params[:entry])
    flash[:notice] = 'Entry was successfully updated.'
    redirect_to entry_path(logged_in_user.id, @entry)
  else
    render :action => "edit"
  end
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = @logged_in_user.entries.find(params[:id])
    @entry.destroy
    
    redirect_to entries_path
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
end
