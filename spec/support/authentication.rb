module AuthenticationForFeatureRequest
  def login user, password
    user.update_attributes password: password

    page.driver.post sessions_url, { user: { email: user.email, password: password } }
    visit root_path
  end
end