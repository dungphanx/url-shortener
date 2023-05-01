class Oauth::GenerateTokenCommand
  DEFAULT_SCOPE = 'user'
  
  prepend SimpleCommand
  include ActiveModel::Validations

  validates :user_id, presence: true
  validate  :valid_user?

  def initialize(user_id:, scope: DEFAULT_SCOPE)
    @user_id = user_id
    @scope =  scope
  end

  def call
    return false if invalid?

    Doorkeeper::AccessToken.create!(
      resource_owner_id: user_id,
      use_refresh_token: true,
      expires_in: Doorkeeper.configuration.access_token_expires_in,
      scopes: scope
    )
  end

  private

  attr_accessor :user_id, :scope

  def valid_user?
    return if User.find_by(id: user_id)

    errors.add(:base, "User dose not exist")
  end
end
