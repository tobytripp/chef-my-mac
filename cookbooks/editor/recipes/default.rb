#
# Cookbook Name:: editor
# Recipe:: default
#
package "emacs" do
  options "--with-cocoa"
end

home = node["editor"]["home"]

bash "link emacs launchd config" do
  code <<-SH
    ln -sfv /usr/local/opt/emacs/*.plist #{home}/Library/LaunchAgents
    launchctl load #{home}/Library/LaunchAgents/homebrew.mxcl.emacs.plist
  SH
  not_if {
    ::File.exist? "#{home}/Library/LaunchAgents/homebrew.mxcl.emacs.plist"
  }
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
