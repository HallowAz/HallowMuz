require 'rails_helper'

RSpec.describe 'Static content', type: :system do
    describe 'Success sign up' do
        let(:login_test) { Faker::Internet.email }
        let(:password_test) { Faker::Internet.password }

        # сценарий успешной регистрации
        scenario 'signin up and logging out' do
            visit autorization_path # переходим на страницы ввода
            find('#sign_up_link').click # нажимаем на кнопку с id="aut_button"
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
        end
    end

  describe 'Unsuccess sign up' do
    # сценарий успешной регистрации
    let(:login_test) { Faker::Internet.email }
    let(:password_test) { Faker::Internet.password }
    scenario 'signin up' do
        visit autorization_path # переходим на страницы ввода
        find('#sign_up_link').click # нажимаем на кнопку с id="aut_button"
        fill_in :user_login, with: login_test # заполняем поле логина
        fill_in :user_password, with: password_test # заполняем поле пароля
        fill_in :user_passwordrepeat, with: password_test + '1'
        find('#reg_submit').click
        expect(page).to have_text('Пароли не совпадают')
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
end



