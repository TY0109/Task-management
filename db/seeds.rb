# coding: utf-8

user1 = User.create!(name: "サンプルユーザーA", email: "samlple-a@email.com", password: "password")
user2 = User.create!(name: "サンプルユーザーB", email: "samlple-b@email.com", password: "password")

3.times do |n|
  task_name = "タスクA#{n + 1}"
  description = "タスク詳細#{n + 1}"
  user1.tasks.create!(name: task_name, description: description)
end

2.times do |n|
  task_name = "タスクB#{n + 1}"
  description = "タスク詳細#{n + 1}"
  user2.tasks.create!(name: task_name, description: description)
end

Task.create(name: "誰のでもないタスク", description: "誰のでもないタスク詳細")
