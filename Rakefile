task default: "chef:solo"

namespace :chef do
  desc "Provision with chef-solo"
  task :solo do |t|
    sh "chef-solo -c solo.rb -j dev.json"
  end
end
