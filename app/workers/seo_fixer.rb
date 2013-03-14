# coding: utf-8
class SeoFixer
  @queue = :seo_fixing

  def self.perform(profile_id)
    profile = Profile.find profile_id
    start_updating = Time.now

    time = '1.03.2013'.to_time

    Generator.all.each { |g| instance_variable_set "@#{g.name}", g.words }

    account = profile.account

    @category_title += [profile.city, profile.shop_name]
    @category_description += [profile.city, profile.shop_name]

    @subcategory_description += [profile.city, profile.shop_name]
    @product_description += [profile.city, profile.shop_name]

    puts "Updating SEO params for #{account.insales_subdomain} at #{start_updating}"
    iapp = InsalesApi::App.new account.insales_subdomain, account.password
    iapp.configure_api
    iapp.store_auth_token
    iapp.authorize iapp.auth_token

    collections = InsalesApi::Collection.all
    catalog = collections.select { |c| c.parent_id == nil }.first

    categories = collections.select { |c| c.parent_id == catalog.id }
    subcategories = collections - [catalog] - categories

    categories = categories.select {|c| c.created_at.to_time >= time}
    subcategories = subcategories.select {|c| c.created_at.to_time >= time}

    if categories.present?
      puts "--Update categories"
      categories.each do |category|
        html_title = category.title + ", " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
        meta_description = category.title + ", " + @category_description.shuffle.first
        meta_keywords = category.title + " " + @category_keywords.shuffle.join(' ')
        category.update_attributes(html_title: html_title,
                                   meta_description: meta_description,
                                   meta_keywords: meta_keywords)
        category.save!
      end
    end

    if subcategories.present?
      puts "--Update subcategories"
      subcategories.each do |subcategory|
        begin
          category = InsalesApi::Collection.find subcategory.parent_id
          html_title = "#{subcategory.title}, #{category.title}, " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
          meta_description = "#{subcategory.title}, " + @subcategory_description.shuffle.first
          meta_keywords = "#{subcategory.title} #{category.title} " + @category_keywords.shuffle.join(' ')
        rescue ActiveResource::ResourceNotFound
          puts "Collection #{subcategory.parent_id} for subcategory #{subcategory.id} is not found"

          account.fail_subcategories.nil? ? account.fail_subcategories = [subcategory.id] : account.fail_subcategories << subcategory.id

          html_title = "#{product.title}, " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
          meta_description = "#{product.title}, " + @product_description.shuffle.first
          meta_keywords = "#{product.title}, " + @category_keywords.shuffle.join(' ')
        end
        subcategory.update_attributes(html_title: html_title,
                                      meta_description: meta_description,
                                      meta_keywords: meta_keywords)
        subcategory.save!
      end
    end


    puts "--Update products"
    page = 1
    if account.last_updated.present?
      products = InsalesApi::Product.all(params: {updated_since: time, page: 1, per_page: 50})
      last_page = products.empty?
      products.select! { |p| p.created_at.to_time > time }
    else
      products = InsalesApi::Product.all(params: {page: 1, per_page: 50})
      last_page = products.empty?
    end

    until last_page
      puts "#{Time.now}: #{page}"
      products.each do |product|
        collection_id = product.canonical_url_collection_id.present? ?
            product.canonical_url_collection_id :
            InsalesApi::Collect.find(:first, params: {product_id: product.id}).try(:collection_id)
        if collection_id
          begin
            #puts "#{product.id}-#{collection_id}"
            collection = InsalesApi::Collection.find collection_id
            html_title = "#{product.title}, #{collection.title}, " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
            meta_description = "#{product.title}, " + @product_description.shuffle.first
            meta_keywords = "#{product.title}, #{collection.title}, " + @category_keywords.shuffle.join(' ')
          rescue ActiveResource::ResourceNotFound
            puts "Collection #{collection_id} for product #{product.id} is not found"
            account.fail_products.nil? ? account.fail_products = [product.id] : account.fail_products << product.id
            html_title = "#{product.title}, " + @category_title.shuffle[0, 3].map { |e| e.class == Array ? e.shuffle.first : e }.join(', ')
            meta_description = "#{product.title}, " + @product_description.shuffle.first
            meta_keywords = "#{product.title}, " + @category_keywords.shuffle.join(' ')
          end
          product.update_attributes(html_title: html_title,
                                    meta_description: meta_description,
                                    meta_keywords: meta_keywords)
          product.save!
        end
      end
      page += 1
      if account.last_updated.present?
        products = InsalesApi::Product.all(params: {updated_since: account.last_updated.to_s, page: page, per_page: 50})
        last_page = products.empty?
        products.select! { |p| p.created_at.to_time > time }
      else
        products = InsalesApi::Product.all(params: {page: page, per_page: 50})
        last_page = products.empty?
      end
    end
    account.update_attribute :last_updated, start_updating
  end
end