require 'test/helper'

class InterpolationsTest < Test::Unit::TestCase
  should "return all methods but the infrastructure when sent #all" do
    methods = Paperclip::Interpolations.all
    assert ! methods.include?(:[])
    assert ! methods.include?(:[]=)
    assert ! methods.include?(:all)
    methods.each do |m|
      assert Paperclip::Interpolations.respond_to?(m)
    end
  end

  should "return the RAILS_ROOT" do
    assert_equal RAILS_ROOT, Paperclip::Interpolations.rails_root(:asset, :style)
  end

  should "return the RAILS_ENV" do
    assert_equal RAILS_ENV, Paperclip::Interpolations.rails_env(:asset, :style)
  end

  should "return the class of the Interpolations module when called with no params" do
    assert_equal Module, Paperclip::Interpolations.class
  end

  should "return the class of the instance" do
    asset = mock
    asset.expects(:instance).returns(asset)
    asset.expects(:class).returns("Thing")
    assert_equal "things", Paperclip::Interpolations.class(asset, :style)
  end

  should "return the basename of the file" do
    asset = mock
    asset.expects(:original_filename).returns("one.jpg").times(2)
    assert_equal "one", Paperclip::Interpolations.basename(asset, :style)
  end

  should "return the extension of the file" do
   asset = mock
    asset.expects(:original_filename).returns("one.jpg")
    asset.expects(:styles).returns({})
    assert_equal "jpg", Paperclip::Interpolations.extension(asset, :style)
  end

  should "return the extension of the file as the format if defined in the style" do
    asset = mock
    asset.expects(:original_filename).never
    asset.expects(:styles).returns({:style => {:format => "png"}})
    assert_equal "png", Paperclip::Interpolations.extension(asset, :style)
  end

  should "return the id of the asset" do
    asset = mock
    asset.expects(:id).returns(23)
    asset.expects(:instance).returns(asset)
    assert_equal 23, Paperclip::Interpolations.id(asset, :style)
  end

  should "return the partitioned id of the asset" do
    asset = mock
    asset.expects(:id).returns(23)
    asset.expects(:instance).returns(asset)
    assert_equal "000/000/023", Paperclip::Interpolations.id_partition(asset, :style)
  end

  should "return the name of the asset" do
    asset = mock
    asset.expects(:name).returns("file")
    assert_equal "files", Paperclip::Interpolations.asset(asset, :style)
  end

  should "return the style" do
    assert_equal :style, Paperclip::Interpolations.style(:asset, :style)
  end

  should "return the default style" do
    asset = mock
    asset.expects(:default_style).returns(:default_style)
    assert_equal :default_style, Paperclip::Interpolations.style(asset, nil)
  end

  should "reinterpolate :url" do
    asset = mock
    asset.expects(:options).returns({:url => ":id"})
    asset.expects(:url).with(:style, false).returns("1234")
    assert_equal "1234", Paperclip::Interpolations.url(asset, :style)
  end

  should "raise if infinite loop detcted reinterpolating :url" do
    asset = mock
    asset.expects(:options).returns({:url => ":url"})
    assert_raises(Paperclip::InfiniteInterpolationError){ Paperclip::Interpolations.url(asset, :style) }
  end

  should "return the filename as basename.extension" do
    asset = mock
    asset.expects(:styles).returns({})
    asset.expects(:original_filename).returns("one.jpg").times(3)
    assert_equal "one.jpg", Paperclip::Interpolations.filename(asset, :style)
  end

  should "return the filename as basename.extension when format supplied" do
    asset = mock
    asset.expects(:styles).returns({:style => {:format => :png}})
    asset.expects(:original_filename).returns("one.jpg").times(2)
    assert_equal "one.png", Paperclip::Interpolations.filename(asset, :style)
  end

  should "return the timestamp" do
    now = Time.now
    asset = mock
    asset.expects(:instance_read).with(:updated_at).returns(now)
    assert_equal now.to_s, Paperclip::Interpolations.timestamp(asset, :style)
  end

  should "call all expected interpolations with the given arguments" do
    Paperclip::Interpolations.expects(:id).with(:asset, :style).returns(1234)
    Paperclip::Interpolations.expects(:asset).with(:asset, :style).returns("assets")
    Paperclip::Interpolations.expects(:notreal).never
    value = Paperclip::Interpolations.interpolate(":notreal/:id/:asset", :asset, :style)
    assert_equal ":notreal/1234/assets", value
  end
end
