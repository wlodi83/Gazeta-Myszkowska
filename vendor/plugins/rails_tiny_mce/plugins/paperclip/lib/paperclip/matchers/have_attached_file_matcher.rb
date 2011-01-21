module Paperclip
  module Shoulda
    module Matchers
      def have_attached_file name
        HaveAttachedFileMatcher.new(name)
      end

      class HaveAttachedFileMatcher
        def initialize asset_name
          @asset_name = asset_name
        end

        def matches? subject
          @subject = subject
          responds? && has_column? && included?
        end

        def failure_message
          "Should have an asset named #{@asset_name}"
        end

        def negative_failure_message
          "Should not have an asset named #{@asset_name}"
        end

        def description
          "have an asset named #{@asset_name}"
        end

        protected

        def responds?
          methods = @subject.instance_methods.map(&:to_s)
          methods.include?("#{@asset_name}") &&
            methods.include?("#{@asset_name}=") &&
            methods.include?("#{@asset_name}?")
        end

        def has_column?
          @subject.column_names.include?("#{@asset_name}_file_name")
        end

        def included?
          @subject.ancestors.include?(Paperclip::InstanceMethods)
        end
      end
    end
  end
end
