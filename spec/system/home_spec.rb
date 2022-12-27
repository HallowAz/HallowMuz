require 'rails_helper'

RSpec.describe 'home', type: :system do
    describe 'Success sign up' do
        let(:login_test) { Faker::Internet.email }
        let(:password_test) { Faker::Internet.password }

        scenario 'signin up and logging out' do
            visit autorization_path 
            find('#sign_up_link').click 
            fill_in :user_login, with: login_test # заполняем поле логина
            fill_in :user_password, with: password_test # заполняем поле пароля
            fill_in :user_passwordrepeat, with: password_test
            find('#reg_submit').click
            expect(page).to have_current_path(home_aut_path)
            click_link 'log_out'
            expect(page).to have_current_path(autorization_path)
            fill_in 'login', with: login_test # заполняем поле логина
            fill_in 'password', with: password_test 
            click_button 'aut_button'
            expect(page).to have_current_path(home_aut_path)
            find('#My_music').click 
            expect(page).to have_text("Библиотека")
            expect(page).to have_text("Плейлисты")
            expect(page).to have_link("Создать плейлист")
            expect(page).to have_link("Загрузить песню")
            expect(page).to have_link("Назад")

            find('#profile_icon').click
            expect(page).to have_text("Профиль")
            expect(page).to have_text("Почта")
            expect(page).to have_link("Редактировать данные")
            expect(page).to have_link("Назад")

            fill_in 'search_field', with: login_test
            click_button "Search_btn"
            expect(page).to have_text("Поиск не дал результатов по данному запросу")
        end
    end

  describe 'Creating playlist' do
    let(:login_test) { Faker::Internet.email }
    let(:password_test) { Faker::Internet.password }
    scenario 'signin up' do
        visit autorization_path 
        find('#sign_up_link').click 
        fill_in :user_login, with: login_test # заполняем поле логина
        fill_in :user_password, with: password_test # заполняем поле пароля
        fill_in :user_passwordrepeat, with: password_test
        find('#reg_submit').click
        expect(page).to have_current_path(home_aut_path)
        click_link 'log_out'
        expect(page).to have_current_path(autorization_path)
        fill_in 'login', with: login_test # заполняем поле логина
        fill_in 'password', with: password_test 
        click_button 'aut_button'
        expect(page).to have_current_path(home_aut_path)

        find('#My_music').click
        click_link 'Создать плейлист'
        expect(page).to have_current_path(creating_playlist_path)
        fill_in "creating_playlist_field", with: login_test
        click_button 'Создать'
        expect(page).to have_text("Библиотека")
        expect(page).to have_text("Плейлисты")
        expect(page).to have_link("Создать плейлист")
        expect(page).to have_link("Загрузить песню")
        expect(page).to have_link("Назад")
        expect(page).to have_button(login_test)
    end
  end

  describe 'Attempts without login' do
    scenario 'signin up' do
        visit autorization_path # переходим на страницы ввода
        visit home_aut_path
        expect(page).to have_current_path(root_path)
        visit autorization_path
        visit library_path
        expect(page).to have_current_path(autorization_path)
        expect(page).to have_text("Сначала необходимо авторизоваться")
        visit autorization_path
        visit profile_path
        expect(page).to have_current_path(autorization_path)
        expect(page).to have_text("Сначала необходимо авторизоваться")
        visit autorization_path
        visit load_path
        expect(page).to have_current_path(autorization_path)
        expect(page).to have_text("Сначала необходимо авторизоваться")
        visit autorization_path
        visit creating_playlist_path
        expect(page).to have_current_path(autorization_path)
        expect(page).to have_text("Сначала необходимо авторизоваться")
        visit autorization_path
        visit edit_playlist_path
        expect(page).to have_current_path(autorization_path)
        expect(page).to have_text("Сначала необходимо авторизоваться")
    end
  end

  describe 'Attempts without login' do
    let(:login_test) { Faker::Internet.email }
    let(:password_test) { Faker::Internet.password }
    scenario 'signin up' do
        visit autorization_path 
        find('#sign_up_link').click 
        fill_in :user_login, with: login_test # заполняем поле логина
        fill_in :user_password, with: password_test # заполняем поле пароля
        fill_in :user_passwordrepeat, with: password_test
        find('#reg_submit').click
        expect(page).to have_current_path(home_aut_path)
        click_link 'log_out'
        expect(page).to have_current_path(autorization_path)
        fill_in 'login', with: login_test # заполняем поле логина
        fill_in 'password', with: password_test 
        click_button 'aut_button'
        expect(page).to have_current_path(home_aut_path)
        
        find('#My_music').click
        click_link 'Загрузить песню'
        
        expect(page).to have_current_path(load_path)
    end
  end

  describe 'Attempts without login' do
    let(:login_test) { Faker::Internet.email }
    let(:password_test) { Faker::Internet.password }
    scenario 'updating' do
        visit autorization_path 
        find('#sign_up_link').click 
        fill_in :user_login, with: login_test # заполняем поле логина
        fill_in :user_password, with: password_test # заполняем поле пароля
        fill_in :user_passwordrepeat, with: password_test
        find('#reg_submit').click
        expect(page).to have_current_path(home_aut_path)
        click_link 'log_out'
        expect(page).to have_current_path(autorization_path)
        fill_in 'login', with: login_test # заполняем поле логина
        fill_in 'password', with: password_test 
        click_button 'aut_button'
        find('#profile_icon').click
        expect(page).to have_text('Профиль')
        click_link 'Редактировать данные'
        fill_in "email_f", with: Faker::Internet.email
        click_button 'Изменить'
        expect(page).to have_text('Данные были успешно изменены')
    end

    scenario 'updating' do
        visit autorization_path 
        find('#sign_up_link').click 
        fill_in :user_login, with: login_test # заполняем поле логина
        fill_in :user_password, with: password_test # заполняем поле пароля
        fill_in :user_passwordrepeat, with: password_test
        find('#reg_submit').click
        expect(page).to have_current_path(home_aut_path)
        click_link 'log_out'
        expect(page).to have_current_path(autorization_path)
        fill_in 'login', with: login_test # заполняем поле логина
        fill_in 'password', with: password_test 
        click_button 'aut_button'
        find('#profile_icon').click
        expect(page).to have_text('Профиль')
        click_link 'Редактировать данные'
        fill_in "password_f", with: Faker::Internet.password(min_length:2, max_length: 5, mix_case: true)
        click_button 'Изменить'
        expect(page).to have_text('Пароль не может быть короче 6 символов')
    end
  end
end



