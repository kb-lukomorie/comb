# coding: utf-8
task :update_seo_params => :environment do
  Profile.all.each do |profile|
    puts "#{Time.now}: Add #{profile.account.insales_subdomain} to queue"
    Resque.enqueue(SeoOptimizer, profile.id)
  end
  puts "done."
end

task :fix_seo_params => :environment do
  Profile.all.each do |profile|
    puts "#{Time.now}: Add #{profile.account.insales_subdomain} to queue"
    Resque.enqueue(SeoFixer, profile.id)
  end
  puts "done."
end

