#
# Cookbook Name:: editor
# Recipe:: default
#
package "emacs" do
  options "--with-cocoa"
end

bash "link emacs launchd config" do
  code <<-SH
    ln -sfv /usr/local/opt/emacs/*.plist ~/Library/LaunchAgents
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.emacs.plist
  SH
  not_if {
    ::File.exist? "~/Library/LaunchAgents/homebrew.mxcl.emacs.plist"
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
