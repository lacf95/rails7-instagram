class Authentication
  include ActiveModel::Model

  attr_accessor :email, :password, :user

  validate :authenticates

  private

  def authenticates
    self.user = User.find_by(email:, password:)
    return if user.present?

    errors.add(:authentication, 'invalid email/password combination')
  end
end
