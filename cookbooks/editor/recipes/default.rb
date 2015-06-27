#
# Cookbook Name:: editor
# Recipe:: default
#
package "emacs" do
  options "--with-cocoa"
end

home = node["editor"]["home"]

plist_file = "#{home}/Library/LaunchAgents/toby.emacs.plist"

template plist_file do
  source "toby.emacs.plist.erb"
end

bash "load emacs launchd config" do
  code "launchctl load #{plist_file}"
  not_if { ::File.exist? plist_file }
end


bash "linkapps" do
  code "brew linkapps emacs"
  not_if { ::File.exist? "/Applications/Emacs.app" }
end

git "#{ENV["HOME"]}/.emacs.d" do
  repository "git@github.com:tobytripp/emacs.d.git"
  revision "master"
  action :sync
end
