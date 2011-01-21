module Paperclip
  module Shoulda
    module Matchers
      def validate_asset_presence name
        ValidateAssetPresenceMatcher.new(name)
      end

      class ValidateAssetPresenceMatcher
        def initialize asset_name
          @asset_name = asset_name
        end

        def matches? subject
          @subject = subject
          error_when_not_valid? && no_error_when_valid?
        end

        def failure_message
          "Asset #{@asset_name} should be required"
        end

        def negative_failure_message
          "Asset #{@asset_name} should not be required"
        end

        def description
          "require presence of asset #{@asset_name}"
        end

        protected

        def error_when_not_valid?
          @asset = @subject.new.send(@asset_name)
          @asset.assign(nil)
          not @asset.errors[:presence].nil?
        end

        def no_error_when_valid?
          @file = StringIO.new(".")
          @asset = @subject.new.send(@asset_name)
          @asset.assign(@file)
          @asset.errors[:presence].nil?
        end
      end
    end
  end
end

