# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :admin do
  desc "Set Aadmin"
  task :set => :environment do

    puts "List of User:"
    puts "N  | Username | Admin  "
    puts "_____________"
    User.all.each do |user|
      puts "#{user.id}....#{user.username }....#{user.admin} "
    end
    puts "write the number to set the admin(exit per exit)"
    answer = STDIN.gets.to_i

    if answer == 0
      puts "!!!!error input!!!!!"

    elsif answer == "exit"

    else
      answer = answer.to_i
      user = User.find(answer)
      user.update(:admin => true)
      puts "now the user:#{user.username} is administrator"
    end
  end

  desc "Remove Aadmin"
  task :remove => :environment do

    puts "List of User:"
    puts "N  | Username | Admin  "
    puts "_____________"
    User.all.each do |user|
      puts "#{user.id}....#{user.username }....#{user.admin} "
    end
    puts "write the number to remove the admin(exit per exit)"
    answer = STDIN.gets.to_i

    if answer == 0
      puts "!!!!error input!!!!!"

    elsif answer == "exit"

    else
      answer = answer.to_i
      user = User.find(answer)
      user.update(:admin => false)
      puts "now the user:#{user.username} isn't administrator"
    end
  end
end
