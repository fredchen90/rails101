namespace :reset do
  desc "Reset posts_count"
  task posts_count: :environment do
    Group.find_each do |group|
      Group.reset_counters(group.id, :posts)
    end
  end
end
