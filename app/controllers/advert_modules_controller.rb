class AdvertModulesController < ApplicationController
  before_filter :check_administrator_role,
                :except => [:index, :change_module]
 
  def index
    @advert_modules = AdvertModule.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advert_modules }
    end
  end

  def change_module
   render :update do |page|
     if params[:name] == "Moduł 1 x 1 (szer 48 x wys 56)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x1'
     elsif params[:name] == "Moduł 2 x 1 (szer 100 x wys 56)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x2a'
     elsif params[:name] == "Moduł 1 x 2 (szer 48 x wys 115)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x2b'
     elsif params[:name] == "Moduł 1 x 3 (szer 48 x wys 174)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x3a'
     elsif params[:name] == "Moduł 3 x 1 (szer 152 x wys 56)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x3b'
     elsif params[:name] == "Moduł 2 x 2 (szer 100 x wys 115)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x4a'
     elsif params[:name] == "Moduł 1 x 4 (szer 48 x wys 233)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x4b'
     elsif params[:name] == "Moduł 4 x 1 (szer 204 x wys 56)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x4c'
     elsif params[:name] == "Moduł 5 x 1 (szer 256 x wys 56)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x5a'
     elsif params[:name] == "Moduł 1 x 5 (szer 48 x wys 292)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x5b'
     elsif params[:name] == "Moduł 1 x 6 (szer 48 x wys 350)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x6a'
     elsif params[:name] == "Moduł 2 x 3 (szer 100 x wys 174)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x6b'
     elsif params[:name] == "Moduł 3 x 2 (szer 152 x wys 115)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x6c'
     elsif params[:name] == "Moduł 4 x 2 (szer 204 x wys 115)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x8a'
     elsif params[:name] == "Moduł 2 x 4 (szer 100 x wys 233)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x8b'
     elsif params[:name] == "Moduł 3 x 3 (szer 152 x wys 174)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x9'
     elsif params[:name] == "Moduł 5 x 2 (szer 256 x wys 115)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x10a'
     elsif params[:name] == "Moduł 2 x 5 (szer 100 x wys 292)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x10b'
     elsif params[:name] == "Moduł 2 x 6 (szer 100 x wys 350)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x12'
     elsif params[:name] == "Moduł 3 x 4 (szer 152 x wys 227)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x12b'
     elsif params[:name] == "Moduł 4 x 3 (szer 204 x wys 171)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x12c'
     elsif params[:name] == "Moduł 5 x 3 (szer 256 x wys 174)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x15'
     elsif params[:name] == "Moduł 3 x 6 (szer 152 x wys 350)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x18'
     elsif params[:name] == "Moduł 5 x 4 (szer 256 x wys 233)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x20'       
     elsif params[:name] == "Moduł 5 x 5 (szer 256 x wys 292)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x25'
     elsif params[:name] == "Moduł 5 x 6 (szer 256 x wys 350)"
       page.replace_html 'module', :partial => 'advert_modules/moduly/modul_1x30'
     end
  end
  end

  def display_module
    if params[:advert_module_name] == "Modul 1 x 1"
      flash[:notice]  = "dxsds"
    else
      flash[:notice] = "acja"
    end
  end

  def admin
    @advert_modules = AdvertModule.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @advert_modules }
    end
  end
  # GET /advert_modules/1
  # GET /advert_modules/1.xml
  def show
    @advert_module = AdvertModule.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @advert_module }
    end
  end

  # GET /advert_modules/new
  # GET /advert_modules/new.xml
  def new
    @advert_module = AdvertModule.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @advert_module }
    end
  end

  # GET /advert_modules/1/edit
  def edit
    @advert_module = AdvertModule.find(params[:id])
  end

  # POST /advert_modules
  # POST /advert_modules.xml
  def create
    @advert_module = AdvertModule.new(params[:advert_module])

    respond_to do |format|
      if @advert_module.save
        flash[:notice] = 'AdvertModule was successfully created.'
        format.html { redirect_to(@advert_module) }
        format.xml  { render :xml => @advert_module, :status => :created, :location => @advert_module }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @advert_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /advert_modules/1
  # PUT /advert_modules/1.xml
  def update
    @advert_module = AdvertModule.find(params[:id])

    respond_to do |format|
      if @advert_module.update_attributes(params[:advert_module])
        flash[:notice] = 'AdvertModule was successfully updated.'
        format.html { redirect_to(@advert_module) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @advert_module.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /advert_modules/1
  # DELETE /advert_modules/1.xml
  def destroy
    @advert_module = AdvertModule.find(params[:id])
    @advert_module.destroy

    respond_to do |format|
      format.html { redirect_to(advert_modules_url) }
      format.xml  { head :ok }
    end
  end
end
