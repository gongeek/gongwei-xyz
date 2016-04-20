# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Article.delete_all
(1..10).to_a.each do |index|
  Article.create(
      title: "夕子的近道#{index}",
      tags: '读书,电影',
      content: %q{这本书讲述一个平凡的故事或者称不上是故事，但是看完后总觉的十分舒服。是啊，每个人都无不走在原本不属于自己的近道上。

                    也许这才是最高境界吧。小说不一定要有波澜起伏的情节故事，真正的高手只需在平凡的生活中道出一些能够引起你共鸣的心境吧!

                    走在近道的感觉永远是那么美好！})
end