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

    categories = collections.select {|c| c.parent_id == catalog.id}
    subcategories = collections - [catalog] - categories

    puts "--Update categories"
    categories.each do |category|
      category.html_title = category.name + ", " + @category_title.shuffle[0, 3+rand(3)].join(', ')
      category.meta_description = category.name + ", " + @category_description.shuffle[0, 3+rand(3)].join(', ')
      category.meta_keywords = category.name + " " + @category_keywords.shuffle[0, 3+rand(3)].join(' ')
      category.save
    end

    puts "--Update subcategories"
    shop_name = "Интернет-магазин" #"Название магазина"
    subcategories.each do |subcategory|
      category = categories.select {|c| subcategory.parent_id == c.id}
      subcategory.html_title = "#{category.name}, #{subcategory.name}, #{shop_name}"
      subcategory.meta_description = "#{category.name}, #{subcategory.name}" + ", " + @subcategory_description.shuffle[0, 3+rand(3)].join(', ')
      subcategory.meta_keywords = "#{category.name}, #{subcategory.name}" + " " + @subcategory_keywords.shuffle[0, 3+rand(3)].join(' ')
      subcategory.save
    end
    puts "--Update products"
    products = InsalesApi::Product.all
    products.each do |product|
      collection_id = product.canonical_url_collection_id.present? ?
          product.canonical_url_collection_id :
          InsalesApi::Collect.find(:first, params: {product_id: product.id}).collection_id
      collection = InsalesApi::Collection.find collection_id
      product.html_title = @product_title_prefix.shuffle[0, 3+rand(3)].join(', ') + ', '
                           + "#{product.title}, #{collection.title}"
                           + @product_title_suffix.shuffle[0, 3+rand(3)].join(', ')
      product.meta_description = @product_description_prefix.shuffle[0, 3+rand(3)].join(', ') + ', '
                                + "#{product.title}, #{collection.title}"
                                + @product_description_suffix.shuffle[0, 3+rand(3)].join(', ')
      product.meta_keywords = "#{product.title}, #{collection.title}" + @product_keywords.shuffle[0, 3+rand(3)].join(', ')
      product.save
    end
  end
  puts "done."
end
