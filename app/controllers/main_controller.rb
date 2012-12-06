# coding: utf-8
class MainController < ApplicationController
  def index

  end

  def seo_optimization
    products = InsalesApi::Product.all
    products.each do |product|
      category = InsalesApi::Collection.find product.canonical_url_collection_id
      product.html_title = "#{product.title} - #{category.title}"
      product.meta_keywords = "#{product.title}, #{category.title}"
      product.meta_description = "#{product.title}, #{product.short_description}"
      product.save
    end
    redirect_to root_path, notice: "Оптимизация успешно завершена"
  end
end
