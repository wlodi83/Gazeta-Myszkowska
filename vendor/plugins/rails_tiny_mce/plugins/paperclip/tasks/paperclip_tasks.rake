def obtain_class
  class_name = ENV['CLASS'] || ENV['class']
  raise "Must specify CLASS" unless class_name
  @klass = Object.const_get(class_name)
end

def obtain_assets
  name = ENV['ASSET'] || ENV['asset']
  raise "Class #{@klass.name} has no assets specified" unless @klass.respond_to?(:asset_definitions)
  if !name.blank? && @klass.asset_definitions.keys.include?(name)
    [ name ]
  else
    @klass.asset_definitions.keys
  end
end

def for_all_assets
  klass = obtain_class
  names = obtain_assets
  ids   = klass.connection.select_values(klass.send(:construct_finder_sql, :select => 'id'))

  ids.each do |id|
    instance = klass.find(id)
    names.each do |name|
      result = if instance.send("#{ name }?")
                 yield(instance, name)
               else
                 true
               end
      print result ? "." : "x"; $stdout.flush
    end
  end
  puts " Done."
end

namespace :paperclip do
  desc "Refreshes both metadata and thumbnails."
  task :refresh => ["paperclip:refresh:metadata", "paperclip:refresh:thumbnails"]

  namespace :refresh do
    desc "Regenerates thumbnails for a given CLASS (and optional ASSET)."
    task :thumbnails => :environment do
      errors = []
      for_all_assets do |instance, name|
        result = instance.send(name).reprocess!
        errors << [instance.id, instance.errors] unless instance.errors.blank?
        result
      end
      errors.each{|e| puts "#{e.first}: #{e.last.full_messages.inspect}" }
    end

    desc "Regenerates content_type/size metadata for a given CLASS (and optional ASSET)."
    task :metadata => :environment do
      for_all_assets do |instance, name|
        if file = instance.send(name).to_file
          instance.send("#{name}_file_name=", instance.send("#{name}_file_name").strip)
          instance.send("#{name}_content_type=", file.content_type.strip)
          instance.send("#{name}_file_size=", file.size) if instance.respond_to?("#{name}_file_size")
          instance.save(false)
        else
          true
        end
      end
    end
  end

  desc "Cleans out invalid assets. Useful after you've added new validations."
  task :clean => :environment do
    for_all_assets do |instance, name|
      instance.send(name).send(:validate)
      if instance.send(name).valid?
        true
      else
        instance.send("#{name}=", nil)
        instance.save
      end
    end
  end
end
