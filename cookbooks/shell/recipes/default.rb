#
# Cookbook Name:: shell
# Recipe:: default
#

package "zsh"
package "tmux"
package "mosh"

home = ENV["HOME"]

git "#{ENV["HOME"]}/dotfiles" do
  repository "git@github.com:tobytripp/dotfiles.git"
  revision "master"
  action :sync
  notifies :run, "bash[install_dotfiles]"
end

bash "install_dotfiles" do
  cwd "#{ENV["HOME"]}/dotfiles"
  code "ruby install.rb"
  creates "#{home}/.zshrc"
end

git "#{ENV["HOME"]}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
end
