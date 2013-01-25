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

    product = InsalesApi::Product.create(category_id: 733197, title: title,
                                         variants_attributes: {variant: {price: price}})

    InsalesApi::Collect.create collection_id: 1189292, product_id: product.id
  end


  puts "done."
end
