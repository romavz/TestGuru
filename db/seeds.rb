# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create!(
  [
    { title: "История" },
    { title: "География" },
    { title: "Базы данных" }
  ]
)

users = User.create!(
  [
    { first_name: "Admin", last_name: "Admin", email: "admin@mamail.ru", password: "123456", password_confirmation: "123456" },
  ]
)

tests = Test.create!(
  [
    { level: 3, category: categories[0], author: users[0], title: "Первые китайские государства" },
    { level: 2, category: categories[0], author: users[0], title: "Древний Рим" },
    { level: 3, category: categories[0], author: users[0], title: "Начало Греко-Персидских войн" },
    { level: 0, category: categories[1], author: users[0], title: "Города и страны" },
    { level: 1, category: categories[1], author: users[0], title: "Горы" },
    { level: 2, category: categories[1], author: users[0], title: "Реки" },
    { level: 1, category: categories[2], author: users[0], title: "Язык SQL" }
  ]
)

questions = Question.create!(
  [
    { test: tests[0], body: "Первая правящая династия?" },
    { test: tests[0], body: "Династия сменившая династию Цинь ?" },
    { test: tests[0], body: "Заче древние китайцы построили великую китайскую стену ?" },
    { test: tests[1], body: "Укажите сословия древнего рима" },
    { test: tests[1], body: "Сколько царей было в древнем риме?" },
    { test: tests[2], body: "Когда случилось восстание в Миллете?" },
    { test: tests[2], body: "Когда произошло Марафонское сражение? " },
    { test: tests[3], body: "Столица России" },
    { test: tests[4], body: "Самая высокая гора кавказа" },
    { test: tests[5], body: "В какое море впадает Волга?" },
    { test: tests[6], body: "Каким запросом создается таблица?" }
  ]
)

Answer.create!(
  [
    { correct: true, question: questions[0], body: "Первой правящей династией в Древнем Китае считается Цинь" },
    { correct: true, question: questions[1], body: "Хань" },
    { correct: true, question: questions[2], body: "Для защиты от набегов кочевников - Гуннов" },
    { correct: false, question: questions[2], body: "Для привлечения туристов" },
    { correct: true, question: questions[3], body: "патриции" },
    { correct: true, question: questions[3], body: "плебеи" },
    { correct: false, question: questions[3], body: "блюбои" },
    { correct: true, question: questions[4], body: "7" },
    { correct: false, question: questions[4], body: "8" },
    { correct: false, question: questions[4], body: "1" },
    { correct: true, question: questions[5], body: "в 500 году до н.э." },
    { correct: true, question: questions[6], body: "12 сентября 490 года до н. э." },
    { correct: true, question: questions[7], body: "Москва" },
    { correct: true, question: questions[8], body: "Эльбрус" },
    { correct: true, question: questions[9], body: "Каспийское море" },
    { correct: true, question: questions[10], body: "CREATE" },
    { correct: false, question: questions[10], body: "INSERT" },
    { correct: false, question: questions[10], body: "NEW" }
  ]
)
