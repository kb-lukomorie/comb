# coding: utf-8
desc "This task is called by the Heroku scheduler add-on"
task :update_seo_params => :environment do
  Account.all.each do |account|
    start_updating = Time.now

    Generator.all.each { |g| instance_variable_set "@#{g.name}", g.words}

    profile = account.profile

    @category_title += [profile.city, profile.shop_name]
    @category_description += [profile.city, profile.shop_name]

    @subcategory_description += [profile.city, profile.shop_name]
    @product_description += [profile.city, profile.shop_name]

    puts "Updating SEO params for #{account.insales_subdomain} at #{start_updating}"
    iapp = InsalesApi::App.new account.insales_subdomain, account.password
    iapp.configure_api
    iapp.store_auth_token
    iapp.authorize iapp.auth_token

    puts 'Main page'
    main_page = InsalesApi::Page.all.select {|p| p.is_main? }.first
    main_page.html_title = "#{profile.shop_description} #{profile.shop_name} #{profile.city}"
    main_page.save

    collections = InsalesApi::Collection.all
    catalog = collections.select{|c| c.parent_id == nil}.first
    collections.delete_if {|c| account.updated_categories.include?(c.id)}  if account.updated_categories.present?

    categories = collections.select {|c| c.parent_id == catalog.id}
    subcategories = collections - [catalog] - categories

    if categories.present?
      puts "--Update categories"
      categories.each do |category|
        category.html_title = category.title + ", " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
        category.meta_description = category.title + ", " + @category_description.shuffle.first
        category.meta_keywords = category.title + " " + @category_keywords.shuffle.join(' ')
        category.save
      end
    end

    if subcategories.present?
      puts "--Update subcategories"
      subcategories.each do |subcategory|
        category = categories.find {|c| subcategory.parent_id == c.id}
        subcategory.html_title = "#{subcategory.title}, #{category.title}, " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
        subcategory.meta_description = "#{subcategory.title}, " + @subcategory_description.shuffle.first
        subcategory.meta_keywords = "#{subcategory.title} #{category.title} " + @category_keywords.shuffle.join(' ')
        subcategory.save
      end
    end

    if account.updated_categories.present?
      account.updated_categories += categories.map(&:id) + subcategories.map(&:id)
    else
      account.updated_categories = categories.map(&:id) + subcategories.map(&:id)
    end
    account.save

    puts "--Update products"
    page = 1
    if account.last_updated.present?
      products = InsalesApi::Product.all(params: {updated_since: account.last_updated.to_s, page: page, per_page: 50})
      last_page = products.empty?
      products.select! {|p| p.created_at > account.last_updated.to_s}
    else
      products = InsalesApi::Product.all(params: {page: page, per_page: 50})
      last_page = products.empty?
    end

    until last_page
      puts "#{Time.now}: #{page}"
      products.each do |product|
        collection_id = product.canonical_url_collection_id.present? ?
            product.canonical_url_collection_id :
            InsalesApi::Collect.find(:first, params: {product_id: product.id}).try(:collection_id)
        if collection_id
          collection = InsalesApi::Collection.find collection_id
          product.html_title = "#{product.title}, #{collection.title}, " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
          product.meta_description = "#{product.title}, " + @product_description.shuffle.first
          product.meta_keywords = "#{product.title}, #{collection.title}, " + @category_keywords.shuffle.join(' ')
          product.save!
        end
      end
      page += 1
      if account.last_updated.present?
        products = InsalesApi::Product.all(params: {updated_since: account.last_updated.to_s, page: page, per_page: 50})
        last_page = products.empty?
        products.select! {|p| p.created_at > account.last_updated.to_s}
      else
        products = InsalesApi::Product.all(params: {page: page, per_page: 50})
        last_page = products.empty?
      end
    end
    account.update_attribute :last_updated, start_updating
  end
  puts "done."
end
