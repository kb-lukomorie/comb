# coding: utf-8
desc "This task is called by the Heroku scheduler add-on"
task :update_seo_params => :environment do
  Generator.all.each { |g| instance_variable_set "@#{g.name}", g.words}
  Account.all.each do |account|
    start_updating = Time.now
    puts "Updating SEO params for #{account.insales_subdomain} at #{start_updating}"
    iapp = InsalesApi::App.new account.insales_subdomain, account.password
    iapp.configure_api
    iapp.store_auth_token
    iapp.authorize iapp.auth_token

    collections = InsalesApi::Collection.all
    catalog = collections.select{|c| c.parent_id == nil}.first

    categories = collections.select {|c| c.parent_id == catalog.id} - account.updated_categories.to_a

    subcategories = collections - [catalog] - categories

    if categories.present?
      puts "--Update categories"
      categories.each do |category|
        category.html_title = category.title + ", " + @category_title.shuffle[0, 3+rand(3)].join(', ')
        category.meta_description = category.title + ", " + @category_description.shuffle[0, 3+rand(3)].join(', ')
        category.meta_keywords = category.title + " " + @category_keywords.shuffle[0, 3+rand(3)].join(' ')
        category.save
      end
    end

    if subcategories.present?
      puts "--Update subcategories"
      shop_name = "Интернет-магазин" #"Название магазина"
      subcategories.each do |subcategory|
        category = categories.find {|c| subcategory.parent_id == c.id}
        subcategory.html_title = "#{subcategory.title}, #{category.title}, #{shop_name}"
        subcategory.meta_description = "#{subcategory.title}, #{category.title}" + ", " + @subcategory_description.shuffle[0, 3+rand(3)].join(', ')
        subcategory.meta_keywords = "#{subcategory.title}, #{category.title}" + " " + @subcategory_keywords.shuffle[0, 3+rand(3)].join(' ')
        subcategory.save
      end
    end

    if account.updated_categories.present?
      account.updated_categories += categories.map(&:id) + subcategories.map(&:id)
    else
      account.updated_categories = categories.map(&:id) + subcategories.map(&:id)
    end

    puts "--Update products"
    if account.last_updated.present?
      products = InsalesApi::Product.find :all, params: {updated_since: account.last_updated.to_s}
      products.select! {|p| p.created_at > account.last_updated.to_s}
    else
      products = InsalesApi::Product.all
    end
    products.each do |product|
      collection_id = product.canonical_url_collection_id.present? ?
          product.canonical_url_collection_id :
          InsalesApi::Collect.find(:first, params: {product_id: product.id}).collection_id
      collection = InsalesApi::Collection.find collection_id
      product.html_title = @product_title_prefix.shuffle[0, 3+rand(3)].join(', ') + ', ' +
                           "#{product.title}, #{collection.title}, " +
                           @product_title_suffix.shuffle[0, 3+rand(3)].join(', ')
      product.meta_description = @product_description_prefix.shuffle[0, 3+rand(3)].join(', ') + ', ' +
                                 "#{product.title}, #{collection.title}, " +
                                 @product_description_suffix.shuffle[0, 3+rand(3)].join(', ')
      product.meta_keywords = "#{product.title}, #{collection.title}, " + @product_keywords.shuffle[0, 3+rand(3)].join(' ')
      product.save
    end
    account.update_attribute :last_updated, start_updating
  end
  puts "done."
end
