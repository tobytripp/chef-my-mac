file_cache_path "#{ENV["HOME"]}/chef-solo"
cookbook_path "#{ENV["HOME"]}/chef-my-mac/cookbooks"

require "pathname"
repo = Pathname.new File.dirname(__FILE__)
encrypted_data_bag_secret File.expand_path repo + ".chef/encrypted_data_bag_secret"
