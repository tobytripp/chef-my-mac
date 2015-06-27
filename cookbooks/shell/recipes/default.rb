#
# Cookbook Name:: shell
# Recipe:: default
#

package "zsh"
package "tmux"
package "mosh"


git "#{ENV["HOME"]}/dotfiles" do
  repository "git@github.com:tobytripp/dotfiles.git"
  revision "master"
  action :sync
end

bash "install dotfiles" do
  cwd "#{ENV["HOME"]}/dotfiles"
  code "ruby install.rb"
end

git "#{ENV["HOME"]}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
end

git "#{ENV["HOME"]}/.emacs.d" do
  repository "git@github.com:tobytripp/emacs.d.git"
  revision "master"
  action :sync
end
