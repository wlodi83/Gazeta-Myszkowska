class ArticlesController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show, :search, :pdf, :rss]
  layout :choose_layout
  require 'fpdf'
  uses_tiny_mce(:options => AppConfig.advanced_mce_options, :only => [:new, :edit]) 
  def pdf
    @article = Article.find(params[:article_id])
    send_data gen_pdf, :filename => "#{@article.title}.pdf", :type => "application/pdf"
  end
  def rss
    @articles = Article.find(:all, :conditions => ["published = ?", true], :order => "id DESC", :limit => 10)
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  def index
    if params[:category_id]
      @articles_pages, @articles = paginate(:articles,
      :include => :user,
      :order => 'published_at DESC',
      :conditions => ["category_id = ? AND published = ?", params[:category_id].to_i, true])
    else
      @articles = Article.find_all_by_published(true)
      @articles_pages, @articles = paginate(:articles,
       :include => :user,
       :order => 'published_at DESC',
       :conditions => ["published = ?", true])
    end
    respond_to do |wants|
      wants.html
      wants.xml  {render :xml => @articles.to_xml }
      wants.rss { render :action => 'rss.xml', :layout => false }
      wants.atom { render :action => 'atom.rxml', :layout => false }
    end
  end
  
  def show
    if is_logged_in? && @logged_in_user.has_role?('Editor')
      @article = Article.find(params[:id])
    else
      @article = Article.find_by_id_and_published(params[:id], true)
    end
    respond_to do |wants|
      wants.html
      wants.xml { render :xml => @article.to_xml }
    end
  end
  
  def search
    params[:q] = params[:q].gsub(/--{2,}/, '-')
    page  = params[:page] || 1 
    @search = Ultrasphinx::Search.new(:query => params[:q],
                                      :page => page,
                                      :per_page => 25)
    @search.run
    @articles = @search.results
    respond_to do |format|
      format.html # search.html.erb
    end
  end
  
  def new
    @article = Article.new
    @attachment = Attachment.new
  end
  
  def create
    @article = Article.new(params[:article])
    @logged_in_user.articles << @article 
    if @article.save 
    process_file_uploads
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :xml => @articles.to_xml }
    end
    else
      render :action => :new    
    end
  end

  def edit
    @article = Article.find(params[:id])
    @newfile = Attachment.new
    @allowed = 20 - @article.attachments.count
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
    process_file_uploads
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :xml => @article.to_xml }  
    end
    else
      redirect_to admin_articles_url
      flash[:error] = "Do not save this article!"
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |wants|
      wants.html { redirect_to admin_articles_url }
      wants.xml { render :nothing => true }
    end
  end

  def admin
    @articles_pages, @articles = paginate(:articles, :order => 'published_at DESC')
  end
  
private
def choose_layout
  if['show'].include? action_name
    'article_layout'
  else
    'application'
  end
end  

def gen_pdf
    pdf=FPDF.new
    data = @article.synopsis
    pdf.AddPage
    pdf.SetFont('Arial','B',16)
    pdf.MultiCell(600,10,data)
    pdf.Output 
end

protected
def process_file_uploads
        i = 0
        while params['file_'+i.to_s] != "" && !params['file_'+i.to_s].nil?
            @attachment = Attachment.new(Hash["uploaded_data" => params['file_'+i.to_s]])
            @article.attachments << @attachment
            i += 1
        end
end
end
