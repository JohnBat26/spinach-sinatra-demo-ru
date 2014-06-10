# language: ru
# encoding: utf-8

Функция: Application test

  Сценарий: Hello world
    Дано I am on the front page
    Тогда I should see a salutation

  Сценарий: Goodbye
    Дано I am on the front page
    Когда I click on the first link
    Тогда Я должен увидеть Goodbye
