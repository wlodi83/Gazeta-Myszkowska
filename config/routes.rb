ActionController::Routing::Routes.draw do |map|
  map.connect '/articles/rss.rxml', :controller => 'articles', :action => 'rss'
  map.resources :homepages
  map.sitemap 'sitemap.xml' , :controller => 'sitemap' , :action => 'sitemap'
  map.resources :contacts
  map.resources :newsletters, :member => {:sendmails => :put}
  map.resources :advert_modules, :collection => { :admin => :get }
  map.resources :advertisements, :collection => { :admin => :get }
  map.resources :attachments
  map.resources :models
  map.resources :entries
  map.resources :newspapers
  map.resources :comments
  map.localization 'localization', :controller => 'newspapers',
                 :action => 'show',
                 :id => '1'                    
  map.resources :forums do |forum|
    forum.resources :topics do |topic|
      topic.resources :posts
    end
  end
  map.index '/', :controller => 'articles',
                 :action => 'index'
  map.about 'about', :controller => 'pages',
                 :action => 'show',
                 :id => '2-o_nas'
  map.resources :articles, :collection => { :admin => :get, :search => :get, :pdf => :get }
  map.resources :categories, :collection => { :admin => :get } do |categories|
    categories.resources :articles
  end
  map.resources :pages
  map.resources :blogs
  map.resources :users, :member => {:enable => :put} do |users|
      users.resources :roles, :name_prefix => 'user_'
      users.resources :entries do |entry|
        entry.resources :comments
      end
      users.resources :articles do |article|
        article.resources :comments
      end
  end
  map.show_user '/user/:username',
                :controller => 'users',
                :action => 'show_by_username'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
