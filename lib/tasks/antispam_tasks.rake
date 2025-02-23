# desc "Explaining what the task does"
# task :antispam do
#   # Task goes here
# end

namespace :antispam do
  desc "Install Antispam by importing IP data"
  task install: :environment do
    Antispam::Iplocator.import
    puts "Antispam IP data imported successfully."
  end
end
