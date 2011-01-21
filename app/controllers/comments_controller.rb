class CommentsController < ApplicationController
  before_filter :login_required, :except => [:show_comment_body]
  before_filter :check_administrator_role, :except => [:create, :new, :show, :show_comment_body, :remove_comment_body]
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all, :conditions => ['published = ?', false], :order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end
  def authorization
    @comment = Comment.find_by_id(params[:comment_id])
    @comment.update_attribute(:published, true)
    if @comment.save!
      render :update do |page|
         page.replace_html 'authorization', :partial => 'comments/authorization', :object => @comment
      end
    end
  end
  def non_authorization
    @comment = Comment.find_by_id(params[:comment_id])
    @comment.update_attribute(:published, false)
    if @comment.save!
      render :update do |page|
         page.replace_html 'non-authorization', :partial => 'comments/non_authorization', :object => @comment
      end
    end
  end
  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end
  
  def show_comment_body
    if is_logged_in?
    @article = Article.find_by_id(params[:article_id])
      render :update do |page|
        page.replace_html 'comment_body', :partial => 'articles/comment_body_input', :object => @article
      end
    else
       render :update do |page|
         page.replace_html 'comment_body', :partial => 'articles/login'
       end
    end 
   end
   def remove_comment_body
      render :update do |page|
        page.remove 'comment_form'
       end
   end
  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @article = Article.find_by_id(params[:article_id])
    @comment = Comment.new(:user_id => @logged_in_user.id,
                           :body => params[:comment][:body])
    respond_to do |format| 
    if @article.comments << @comment
      flash[:notice] = 'Komentarz został dodany i czeka na autoryzację' 
      format.html { redirect_to article_url(@article) }
    else
      if params[:comment][:body].empty?
      flash[:error] = 'Treść komentarza nie może być pusta.'
      format.html { redirect_to article_url(@article) }
      else
      flash[:error] = 'Treść komentarza nie może zawierać więcej niż 10000 znaków.'
      format.html { redirect_to article_url(@article) }
      end 
    end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @article = @article = Article.find_by_id(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end
end
