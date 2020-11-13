namespace :subscription do
  desc "subscription function for members"

  task subscription_task: :environment do
    Card.subscription
  end
end
