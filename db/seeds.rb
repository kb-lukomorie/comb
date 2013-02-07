# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Generator.destroy_all

Generator.create! name: 'category_title',
                  words:  ["купить", ["интернет магазин", "интернет-магазин", "online", "онлайн"], ["заказать", "заказ"],
                           ["цена", "стоимость", "цены"], "2013", ["дёшево", "не дорого"], "каталог"]

Generator.create! name: "category_description",
                  words: ["c доставкой", "интернет магазин", "заказ онлайн", "консультации", "доставка",
                          "купить в интернет магазине"]
Generator.create! name: "category_keywords",
                  words: ["купить", "интернет магазин", "онлайн", "заказать", "заказ", "цена", "стоимость", "каталог"]

Generator.create! name: "subcategory_description",
                  words: ["с доставкой", "интернет магазин", "заказ онлайн", "консультации", "доставка",
                          "купить в интернет магазине"]

Generator.create! name: "product_description",
                  words: ["с доставкой", "интернет магазин", "заказ онлайн", "консультации", "доставка",
                          "купить в интернет магазине", "выгодные условия на покупку"]
