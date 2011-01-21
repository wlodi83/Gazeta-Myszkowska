When /^I attach an? "([^\"]*)" "([^\"]*)" file to an? "([^\"]*)" on S3$/ do |asset, extension, model|
  stub_paperclip_s3(model, asset, extension)
  attach_file asset,
              "features/support/paperclip/#{model.gsub(" ", "_").underscore}/#{asset}.#{extension}"
end

