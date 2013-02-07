# coding: utf-8
desc "Populate shop"
task :shop_populate => :environment do
  require 'csv'

  puts 'Start'
  a = Account.first
  iapp = InsalesApi::App.new a.insales_subdomain, a.password
  iapp.configure_api
  iapp.store_auth_token
  iapp.authorize iapp.auth_token
  iapp.authorized?

  CSV.foreach('products.csv', headers: true) do |row|
    title = row.field('bname')
    price = row.field('bopt').to_f

    product = InsalesApi::Product.create(category_id: 734512, title: title,
                                         variants_attributes: {variant: {price: price}})

    InsalesApi::Collect.create collection_id: 1196036, product_id: product.id
  end


  puts "done."
end

task :public_products => :environment do
  a = Account.first
  iapp = InsalesApi::App.new a.insales_subdomain, a.password
  iapp.configure_api
  iapp.store_auth_token
  iapp.authorize iapp.auth_token

  # books
  puts 'books'
  page = 14
  products = InsalesApi::Product.all(params: {page: page, per_page: 250, category_id: 737743})

  until products.empty?
    puts "#{Time.now}: #{page}"
    products.each do |product|
      InsalesApi::Collect.create collection_id: 1189292, product_id: product.id
    end
    page += 1
    products = InsalesApi::Product.all(params: {page: page, per_page: 250, category_id: 737743})
  end

  # tech
  puts 'tech'
  page = 1
  products = InsalesApi::Product.all(params: {page: page, per_page: 250, category_id: 737738})

  until products.empty?
    puts "#{Time.now}: #{page}"
    products.each do |product|
      InsalesApi::Collect.create collection_id: 1058155, product_id: product.id
    end
    page += 1
    products = InsalesApi::Product.all(params: {page: page, per_page: 250, category_id: 737738})
  end
end