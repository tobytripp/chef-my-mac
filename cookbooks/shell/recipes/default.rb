#
# Cookbook Name:: shell
# Recipe:: default
#

package "ag"
package "zsh"
package "tmux"
package "mosh"

home = ENV["HOME"]

keys = Chef::EncryptedDataBagItem.load("keys", "github")
private_key = "#{home}/.ssh/github_rsa"
file private_key do
  mode 0600
  content keys["ssh-private"]
  not_if { ::File.exist? private_key }
#  notifies :run, 'execute[ssh_add]', :immediately
end

# execute "ssh_add" do
#   command "ssh-add #{private_key}"
# end

public_key = "#{home}/.ssh/github_rsa.pub"
file public_key do
  mode 0600
  content keys["ssh-public"]
  not_if { ::File.exist? public_key }
end

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

