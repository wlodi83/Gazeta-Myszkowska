require 'test/helper'

class ValidateAssetPresenceMatcherTest < Test::Unit::TestCase
  context "validate_asset_presence" do
    setup do
      reset_table("dummies"){|d| d.string :avatar_file_name }
      @dummy_class = reset_class "Dummy"
      @dummy_class.has_attached_file :avatar
      @matcher     = self.class.validate_asset_presence(:avatar)
    end

    should "reject a class with no validation" do
      assert_rejects @matcher, @dummy_class
    end

    should "accept a class with a validation" do
      @dummy_class.validates_asset_presence :avatar
      assert_accepts @matcher, @dummy_class
    end
  end
end
