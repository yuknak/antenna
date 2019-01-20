# encoding: utf-8

# bundle exec rails seed:up
# bundle exec rails seed:down

namespace :seed do

  task up: :environment do |task, args|
    Dir.chdir(Rails.root) do
      if ENV['SSH_PORT'].blank? then
        puts "Specify export SSH_PORT=22 or else."
        next
      end
      today = `date +%Y%m%d`
      today.chomp!
      `rm -f db/seeds.rb`
      `bundle exec rails db:seed:dump MODELS=Category`
      `bundle exec rails db:seed:dump MODELS=Site APPEND=true`
      `bundle exec rails db:seed:dump MODELS=Article APPEND=true`
      `bundle exec rails db:seed:dump MODELS=DailyWeight APPEND=true`
      seed_fname = "antenna-seed-#{today}.tgz"
      img_fname = "antenna-img-#{today}.tgz"
      `tar cvzf #{seed_fname} db/seeds.rb`
      `tar cvzf #{img_fname} public/img`
      `scp -P #{ENV['SSH_PORT']} #{seed_fname} yuknak@corp.yuknak.site:/home/yuknak/download`
      `scp -P #{ENV['SSH_PORT']} #{img_fname} yuknak@corp.yuknak.site:/home/yuknak/download`
    end    
  end

  task down: :environment do |task, args|
    Dir.chdir(Rails.root) do
      day = '20190120'
      seed_fname = "antenna-seed-#{day}.tgz"
      img_fname = "antenna-img-#{day}.tgz"
      `wget http://corp.yuknak.site/download/#{seed_fname}`
      `wget http://corp.yuknak.site/download/#{img_fname}`
      `tar xvzf #{seed_fname}`
      `tar xvzf #{img_fname}`
    end 
  end

end