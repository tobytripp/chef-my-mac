#
# Cookbook Name:: ruby
# Recipe:: default
#
git "#{ENV["HOME"]}/.rbenv" do
  repository "https://github.com/sstephenson/rbenv.git"
end

package "ruby-build"
