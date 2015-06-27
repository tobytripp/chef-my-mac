#
# Cookbook Name:: apps
# Recipe:: default
#
homebrew_tap 'caskroom/cask'
package "brew-cask" do
  action :install
end

%w[
  dropbox
  flux
  google-chrome
  iterm2
].each { |cask| homebrew_cask cask }

bash "open apps" do
  code "open -a #{ENV["HOME"]}/Applications/Flux.app"
end
