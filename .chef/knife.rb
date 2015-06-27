require "pathname"
cookbook_path ["#{ENV["HOME"]}/chef-my-mac/cookbooks"]
secret_file   Pathname.new( File.dirname(__FILE__) ) +
              ".chef/encrypted_data_bag_secret"
