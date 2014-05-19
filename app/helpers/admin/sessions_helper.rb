module Admin::SessionsHelper
  def sign_in(member)
    remember_token = Member.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    member.update_attribute(:remember_token, Member.digest(remember_token))
    self.current_member = admin_member
  end
  def current_member=(member)
    @current_member = admin_member
  end
  def current_member
    remember_token = Member.digest(cookies[:remember_token])
    @current_member ||= Member.find_by(remember_token: remember_token)
  end
  def signed_in?
    !current_member.nil?
  end
  def signed_in_member
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  def sign_out
    current_member.not_validate_password = true
    current_member.update_attributes(remember_token:
                                  User.digest(User.new_remember_token))
    current_member.not_validate_password = false
    cookies.delete(:remember_token)
    self.current_member = nil
  end
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  def store_location
    session[:return_to] = request.url if request.get?
  end
  def admin_member? member
    member.admin
  end
  def admin_member
    current_member.admin
  end
end