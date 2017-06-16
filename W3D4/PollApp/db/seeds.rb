# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create!(user_name: "Dude1")
u2 = User.create!(user_name: "Dude2")
u3 = User.create!(user_name: "Dude3")
u4 = User.create!(user_name: "Dude4")
u5 = User.create!(user_name: "Dude5")

p1 = Poll.create!(author_id: u1.id, title: "title1")
p2 = Poll.create!(author_id: u2.id, title: "title2")
p3 = Poll.create!(author_id: u3.id, title: "title3")
p4 = Poll.create!(author_id: u4.id, title: "title4")
p5 = Poll.create!(author_id: u5.id, title: "title5")

q1 = Question.create!(poll_id: p1.id, text: "Text1")
q2 = Question.create!(poll_id: p2.id, text: "Text2")
q3 = Question.create!(poll_id: p3.id, text: "Text3")
q4 = Question.create!(poll_id: p4.id, text: "Text4")
q5 = Question.create!(poll_id: p5.id, text: "Text5")

a1 = AnswerChoice.create!(question_id: q1.id, text: "Any Text 1")
a2 = AnswerChoice.create!(question_id: q2.id, text: "Any Text 2")
a3 = AnswerChoice.create!(question_id: q3.id, text: "Any Text 3")
a4 = AnswerChoice.create!(question_id: q4.id, text: "Any Text 4")
a5 = AnswerChoice.create!(question_id: q5.id, text: "Any Text 5")


r1 = Response.create!(user_id: u1.id, answer_choice_id: a1.id, question_id: q1.id)
r2 = Response.create!(user_id: u2.id, answer_choice_id: a2.id, question_id: q2.id)
r3 = Response.create!(user_id: u3.id, answer_choice_id: a3.id, question_id: q3.id)
r4 = Response.create!(user_id: u4.id, answer_choice_id: a4.id, question_id: q4.id)
r5 = Response.create!(user_id: u5.id, answer_choice_id: a5.id, question_id: q5.id)
r6 = Response.create!(user_id: u1.id, answer_choice_id: a1.id, question_id: q5.id)
