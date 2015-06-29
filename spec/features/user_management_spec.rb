require 'spec_helper'
require_relative 'helpers/session'
include SessionHelpers

feature 'User signs up' do
  scenario 'when being a new user visiting the site' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, Guillaume@bouffard.com')
  end

  scenario 'with a password that does not match' do
    expect { sign_up('mr_wrong@wrong.com', 'pass', 'wrong') }.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content('Sorry! Your passwords do not match')
  end

  scenario 'with an email that is already registered' do
    expect { sign_up }.to change(User, :count).by(1)
    expect { sign_up }.to change(User, :count).by(0)
    expect(page).to have_content('This email is already taken')
  end
end

feature 'User signs in' do
  before(:each) do
    User.create(email: 'Guillaume@bouffard.com',
                password: 'whatever',
                password_confirmation: 'whatever')
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, Guillaume@bouffard.com')
    sign_in('Guillaume@bouffard.com', 'whatever')
    expect(page).to have_content('Welcome, Guillaume@bouffard.com')
  end

  scenario 'with incorrect credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, Guillaume@bouffard.com')
    sign_in('Guillaume@bouffard.com', 'wrongpassword')
    expect(page).not_to have_content('Welcome, Guillaume@bouffard.com')
  end
end

feature 'User signs out' do
  before(:each) do
    User.create(email: 'Guillaume@bouffard.com',
                password: 'whatever',
                password_confirmation: 'whatever')
  end

  scenario 'while being signed in' do
    sign_in('Guillaume@bouffard.com', 'whatever')
    click_button 'Sign out'
    expect(page).to have_content('Good bye!')
    expect(page).not_to have_content('Welcome, Guillaume@bouffard.com')
  end
end
