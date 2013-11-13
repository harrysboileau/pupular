module SignInSignUpSpecHelper

  def guest_sign_up(dog)
    go_to_signup
    fill_out_human_info(dog)
    fill_out_dog_info(dog)
  end

  def go_to_signup
    visit root_path
    page.find("#sign_up").click
  end

  def fill_out_human_info(dog, password_input = nil)
    confirm = password_input.nil? ? dog[:password] : password_input
    fill_in "dog_email", with: dog[:email]
    fill_in "dog_password", with: dog[:password]
    fill_in "dog_password_confirmation", with: confirm
    submit
  end

  def fill_out_dog_info(dog)
    fill_in "dog_username", with: dog[:username]
    fill_in "dog_name", with: dog[:name]
    submit
  end

  def submit
    page.find(".call_to_action").click
  end

  def dog_login_email(dog)
    username = dog[:email]
    dog_login(username)
  end

  def dog_login_username(dog)
    username = dog[:username]
    dog_login(username)
  end

  def dog_login(username)
    go_to_login
    fill_out_login_info(username)
    submit
  end

  def go_to_login
    visit root_path
    page.find("#sign_in").click
  end

  def fill_out_login_info(username)
    fill_in "dog_session_username", with: username
    fill_in "dog_session_password", with: "password"
  end
end
