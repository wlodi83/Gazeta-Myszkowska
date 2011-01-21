module Paperclip
  # This module contains all the methods that are available for interpolation
  # in paths and urls. To add your own (or override an existing one), you
  # can either open this module and define it, or call the
  # Paperclip.interpolates method.
  module Interpolations
    extend self

    # Hash assignment of interpolations. Included only for compatability,
    # and is not intended for normal use.
    def self.[]= name, block
      define_method(name, &block)
    end

    # Hash access of interpolations. Included only for compatability,
    # and is not intended for normal use.
    def self.[] name
      method(name)
    end

    # Returns a sorted list of all interpolations.
    def self.all
      self.instance_methods(false).sort
    end

    # Perform the actual interpolation. Takes the pattern to interpolate
    # and the arguments to pass, which are the asset and style name.
    def self.interpolate pattern, *args
      all.reverse.inject( pattern.dup ) do |result, tag|
        result.gsub(/:#{tag}/) do |match|
          send( tag, *args )
        end
      end
    end

    # Returns the filename, the same way as ":basename.:extension" would.
    def filename asset, style
      "#{basename(asset, style)}.#{extension(asset, style)}"
    end

    # Returns the interpolated URL. Will raise an error if the url itself
    # contains ":url" to prevent infinite recursion. This interpolation
    # is used in the default :path to ease default specifications.
    def url asset, style
      raise InfiniteInterpolationError if asset.options[:url].include?(":url")
      asset.url(style, false)
    end

    # Returns the timestamp as defined by the <asset>_updated_at field
    def timestamp asset, style
      asset.instance_read(:updated_at).to_s
    end

    # Returns the RAILS_ROOT constant.
    def rails_root asset, style
      RAILS_ROOT
    end

    # Returns the RAILS_ENV constant.
    def rails_env asset, style
      RAILS_ENV
    end

    # Returns the underscored, pluralized version of the class name.
    # e.g. "users" for the User class.
    # NOTE: The arguments need to be optional, because some tools fetch
    # all class names. Calling #class will return the expected class.
    def class asset = nil, style = nil
      return super() if asset.nil? && style.nil?
      asset.instance.class.to_s.underscore.pluralize
    end

    # Returns the basename of the file. e.g. "file" for "file.jpg"
    def basename asset, style
      asset.original_filename.gsub(/#{File.extname(asset.original_filename)}$/, "")
    end

    # Returns the extension of the file. e.g. "jpg" for "file.jpg"
    # If the style has a format defined, it will return the format instead
    # of the actual extension.
    def extension asset, style 
      ((style = asset.styles[style]) && style[:format]) ||
        File.extname(asset.original_filename).gsub(/^\.+/, "")
    end

    # Returns the id of the instance.
    def id asset, style
      asset.instance.id
    end

    # Returns the id of the instance in a split path form. e.g. returns
    # 000/001/234 for an id of 1234.
    def id_partition asset, style
      ("%09d" % asset.instance.id).scan(/\d{3}/).join("/")
    end

    # Returns the pluralized form of the asset name. e.g.
    # "avatars" for an asset of :avatar
    def asset asset, style
      asset.name.to_s.downcase.pluralize
    end

    # Returns the style, or the default style if nil is supplied.
    def style asset, style
      style || asset.default_style
    end
  end
end
