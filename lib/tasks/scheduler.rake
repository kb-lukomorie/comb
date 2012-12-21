desc "This task is called by the Heroku scheduler add-on"
task :update_seo_params => :environment do
  generators = [r]
  Account.all.each do |account|
    start_updating = Time.now
    puts "Updating SEO params for #{account.insales_subdomain} at #{start_updating}"
    iapp = InsalesApi::App.new account.insales_subdomain, account.password
    iapp.configure_api
    iapp.store_auth_token
    iapp.authorize iapp.auth_token

    collections = InsalesApi::Collection.all
    catalog = collections.select{|c| c.parent_id == nil}.first

    categories = collections.select {|c| c.parent_id == catalog.id}
    subcategories = collections - [catalog] - categories

    puts "--Update categories"
    categories.each do |category|

    end

    puts "--Update subcategories"
    subcategories.each do |subcategory|

    end
    puts "--Update products"
    products = InsalesApi::Product.all
    products.each do |product|
      collection_id = product.canonical_url_collection_id.present? ?
          product.canonical_url_collection_id :
          InsalesApi::Collect.find(:first, params: {product_id: product.id}).collection_id
      collection = InsalesApi::Collection.find collection_id
      product.html_title = "#{product.title}, #{collection.title}"
      product.meta_keywords = "#{product.title}, #{collection.title}"
      product.meta_description = "#{product.title}, #{product.short_description}"
      product.save
    end
  end
  puts "done."
end
