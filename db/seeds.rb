# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Generator.destroy_all

Generator.create! name: "category_title", words: %w(азида
азиде
азоте
азоту
аксон
актам
анион
анода
аноде
аноду
аноды
аргус
атоме
атому)
Generator.create! name: "category_description", words: %w(бария
битах
борид
браве
браге
брома
бутов
введи
ввода
вводу
вводя
витке
вихрю
)
Generator.create! name: "category_keywords", words: %w(влёта
влёте
вузов
геоид
гипер
гофра
грант
грибу
гросс
дзета
диады
динам
динах
диной
диною
диода
диоде
диоду
диоды
дозам
дозой
домен
донец
дубин
дубле
дугах
)

Generator.create! name: "subcategory_description", words: %w(дырке
дырок
замен
зобов
зонам
зонде
зонды
ионам
ионах
ионно
ионом
каган
калии
калия
катод
кварк
клеев
)
Generator.create! name: "subcategory_keywords", words: %w(ключе
комой
конов
котёл
кузин
кулик
кулон
лавин
лемме
ливни
линзе
линзу
лития
ломов
лунка
лунке
лунки
лунку
лунок
масел
)

Generator.create! name: "product_title_prefix", words: %w(мезон
микро
модах
молем
мюона
мюоне
мюоны
набла
некой
неоне
нулей
нулём
олова
олове
омами
опале
ортам
ортов
осями
отжиг
очаги
пикам
плазм
полые
)
Generator.create! name: "product_title_suffix", words: %w(полых
порам
призм
пучке
пучку
пятых
ранге
рангу
реале
ребра
ребёр
репер
ринга
родам
ромба
ромбу
ромбы
)
Generator.create! name: "product_description_prefix", words: %w(ручек
рыбин
рыжик
рёбер
рёбра
сакса
сбоем
сброс
свана
сдано
синус
скола
сколе
сколу
скоса
слоям
слоёв
слюде
смоле
снято
солях
сопла
сорту
спада
спаде
спаду
спады
спина
спине
спину
спины
срезе
срезу
)
Generator.create! name: "product_description_suffix", words: %w(срезы
срыву
створ
сушка
схожа
схожи
твист
терма
терме
терму
термы
теске
тесты
тигле
тигля
типах
токам
токов
торец
торце
торцы
трека
триод
турку
)
Generator.create! name: "product_keywords", words: %w(убыли
фазам
фазах
фазис
фазой
фенол
фонду
фонон
фрезе
фриза
ходов
хорды
хрома
цезии
цезий
цезия
церии
церия
цинка
шабер
шайбы
шарма
шейки
шифра
шихты
шлифа
шлифе
)
