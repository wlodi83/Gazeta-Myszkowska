# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def yes_no(bool)
    if bool == true
      "tak"
    else
      "nie"
    end
  end
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def kataklizm_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Kataklizm') and published=#{true} order by published_at DESC limit 10"))
  end
  def kataklizm_img
     render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Kataklizm') and published=#{true} order by published_at DESC limit 1")) 
  end
  def wydarzenia_partial
     render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Wydarzenia') and published=#{true} order by published_at DESC limit 10")) 
  end
  def wydarzenia_img
     render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Wydarzenia') and published=#{true} order by published_at DESC limit 1")) 
  end
  def komentarz_partial
     render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Komentarz Polityczny') and published=#{true} order by published_at DESC limit 10"))
  end
  def komentarz_img
     render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Komentarz Polityczny') and published=#{true} order by published_at DESC limit 1"))
  end
  def polityka_partial
     render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Polityka') and published=#{true} order by published_at DESC limit 10"))
  end
  def polityka_img
     render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Polityka') and published=#{true} order by published_at DESC limit 1"))
  end
  def kultura_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Kultura') and published=#{true} order by published_at DESC limit 10"))
  end
  def kultura_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Kultura') and published=#{true} order by published_at DESC limit 1"))
  end
  def sport_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Sport') and published=#{true} order by published_at DESC limit 10"))
  end
  def sport_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Sport') and published=#{true} order by published_at DESC limit 1"))
  end
  def gospodarka_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Gospodarka') order by published_at DESC limit 10"))
  end
  def gospodarka_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Gospodarka') and published=#{true} order by published_at DESC limit 1"))
  end
  def co_gdzie_kiedy_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Co? Gdzie? Kiedy?') and published=#{true} order by published_at DESC limit 10"))
  end
  def co_gdzie_kiedy_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Co? Gdzie? Kiedy?') and published=#{true} order by published_at DESC limit 1"))
  end
  def oswiata_partial
    render(:partial => "layouts/right_panel1_links", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Oświata') and published=#{true} order by published_at DESC limit 10"))
  end
  def oswiata_img
    render(:partial => "layouts/right_image_link", :collection => Article.find_by_sql("select title, id from articles where category_id in(select id from categories where name like 'Oświata') and published=#{true} order by published_at DESC limit 1"))
  end
  def kategorie_partial
    render(:partial => "layouts/category", :collection => Category.find(:all, :conditions => ["parent_id is null"]))
  end
  def main_partial
    render(:partial => "articles/main",  :collection => Article.find_by_sql("select title, id, synopsis from articles where published=#{true} order by published_at DESC limit 1"))
  end
  def right_partial
    render(:partial => "articles/right_partial", :collection => Article.find_by_sql("select * from articles where published = true AND id != (select id from articles ORDER BY published_at DESC LIMIT 1) ORDER BY published_at DESC LIMIT 3;"))
  end
  def list_articles_partial
    render(:partial => "articles/list_articles_partial", :collection => Article.find_by_sql("select * from articles where published = true ORDER BY published_at DESC LIMIT 5 OFFSET 4"))
  end
  def ten_articles_partial
    render(:partial => "articles/ten_articles_partial", :collection => Article.find_by_sql("select * from articles where published = true ORDER BY published_at DESC LIMIT 100 OFFSET 9"))
  end
  def tree_ul(acts_as_tree_set, init=true, &block)
    if acts_as_tree_set.size > 0
      ret = '<ul>'
      acts_as_tree_set.collect do |item|
        next if item.parent_id && init
        ret += '<li>'
        ret += yield item
        ret += tree_ul(item.children, false, &block) if item.children.size > 0
        ret += '</li>'
      end
      ret += '</ul>'
    end
  end

end
