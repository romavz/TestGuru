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
    { name: "Admin", nick_name: "Admin" },
    { name: "User B", nick_name: "nick User B" },
    { name: "User C", nick_name: "nick User C" }
  ]
)

tests = Test.create!(
  [
    { level: 3, category_id: categories[0].id, title: "Первые китайские государства" },
    { level: 2, category_id: categories[0].id, title: "Древний Рим" },
    { level: 3, category_id: categories[0].id, title: "Начало Греко-Персидских войн" },
    { level: 0, category_id: categories[1].id, title: "Города и страны" },
    { level: 1, category_id: categories[1].id, title: "Горы" },
    { level: 2, category_id: categories[1].id, title: "Реки" },
    { level: 1, category_id: categories[2].id, title: "Язык SQL" }
  ]
)

questions = Question.create!(
  [
    { test_id: tests[0].id, body: "Первая правящая династия?" },
    { test_id: tests[0].id, body: "Династия сменившая династию Цинь ?" },
    { test_id: tests[0].id, body: "Заче древние китайцы построили великую китайскую стену ?" },
    { test_id: tests[1].id, body: "Укажите сословия древнего рима" },
    { test_id: tests[1].id, body: "Сколько царей было в древнем риме?" },
    { test_id: tests[2].id, body: "Когда случилось восстание в Миллете?" },
    { test_id: tests[2].id, body: "Когда произошло Марафонское сражение? " },
    { test_id: tests[3].id, body: "Столица России"},
    { test_id: tests[4].id, body: "Самая высокая гора кавказа"},
    { test_id: tests[5].id, body: "В какое море впадает Волга:" },
    { test_id: tests[6].id, body: "Каким запросом создается таблица" }
  ]
)

answers = Answer.create!(
  [
    { correct: true, question_id: questions[0].id, body: "Первой правящей династией в Древнем Китае считается Цинь" },
    { correct: true, question_id: questions[1].id, body: "Хань" },
    { correct: true, question_id: questions[2].id, body: "Для защиты от набегов кочевников - Гуннов" },
    { correct: false, question_id: questions[2].id, body: "Для привлечения туристов" },
    { correct: true, question_id: questions[3].id, body: "патриции" },
    { correct: true, question_id: questions[3].id, body: "плебеи" },
    { correct: false, question_id: questions[3].id, body: "блюбои" },
    { correct: true, question_id: questions[4].id, body: "7" },
    { correct: false, question_id: questions[4].id, body: "8" },
    { correct: false, question_id: questions[4].id, body: "1" },
    { correct: true, question_id: questions[5].id, body: "в 500 году до н.э." },
    { correct: true, question_id: questions[6].id, body: "12 сентября 490 года до н. э." },
    { correct: true, question_id: questions[7].id, body: "Москва" },
    { correct: true, question_id: questions[8].id, body: "Эльбрус" },
    { correct: true, question_id: questions[9].id, body: "Каспийское море" },
    { correct: true, question_id: questions[10].id, body: "CREATE" },
    { correct: false, question_id: questions[0].id, body: "INSERT" },
    { correct: false, question_id: questions[0].id, body: "NEW" },
  ]
)

user_tests = UserTest.create!(
  [
    { user_id: users[1].id, test_id: tests[0].id, passed: true },
    { user_id: users[1].id, test_id: tests[2].id, passed: false },
    { user_id: users[2].id, test_id: tests[5].id, passed: false },
    { user_id: users[2].id, test_id: tests[6].id, passed: true },
    { user_id: users[2].id, test_id: tests[3].id, passed: true }
  ]
)
