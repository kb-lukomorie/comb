# coding: utf-8
class MainController < ApplicationController
  def index
    @profile = @account.build_profile unless @account.profile.present?

  end

  def seo_optimization
    #debugger
    products = InsalesApi::Product.all
    products.each do |product|
      collection_id = InsalesApi::Collect.find(:first, params: {product_id: product.id}).collection_id
      collection = InsalesApi::Collection.find collection_id
      product.html_title = "#{product.title} - #{collection.title}"
      product.meta_keywords = "#{product.title}, #{collection.title}"
      product.meta_description = "#{product.title}, #{product.short_description}"
      product.save
    end
    redirect_to root_path, notice: 'Оптимизация успешно завершена'
  end
end
