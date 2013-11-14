module UserProfileSpecHelper

  def profile_sign_up
    guest_sign_up(attributes_for(:dog, name: "tester"))
  end
  def fill_out_profile
    profile = attributes_for(:profile)
    fill_in "profile_breed", with: "sheep dog"
    fill_in "profile_location", with: "341 W. Hubbard St."
    fill_in "profile_age", with: profile[:age]
    select('Medium', :from => 'profile_size')
    select('Male', :from => 'profile_gender')
    select('Yes', :from => 'profile_spayed')
  end
end
