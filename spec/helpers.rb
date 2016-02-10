module Helpers

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end
  def open
  	save_and_open_page
  end
  def html
  	puts page.html
  end
end