require 'test/test_helper'
require 'articles_controller'

class ArticlesController; def rescue_action(e) raise e end; end

class ArticlesControllerTest < ActionController::TestCase
  fixtures :articles, :users, :roles, :roles_users
  
  def setup
    @controller = ArticlesController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end
 
  def index
   get :index
   assert_response :success
   assert_not_nil assigns(:articles)   
  end
  
  def test_index_as_xml
    @request.env['HTTP_ACCEPT'] = 'application/xml'
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end
  
  def test_show
    get :show, :id => 1
    assert_response :success
    assert_not_nil  assigns(:article)
  end
  
  def test_create_article_with_http_auth_and_xml
    old_count = Article.count
    @request.env['HTTP-ACCEPT'] = 'application/xml'
    @request.env['Authorization'] = 'Basic' + Base64::b64encode('editor@example.com:12345')
    
    post :create, :article => { :title => 'New Article 2', :synopsis => 'Just a test', :body => 'Nothing to see there', :published => true }
    assert_response :success
    assert_equal old_count + 1, Article.count
    assert_not_nil assigns(:article) 
  end
  
  def test_rest_routing
    with_options :controller => 'articles' do |test|
      test.assert_routing 'articles', :action => 'index'
      test.assert_routing 'articles/1', :action => 'show', :id => '1'
    end
  end
  
end
