# AWS プロバイダの設定
provider "aws" {
  region = "ap-northeast-1" # 適切なリージョンに変更してください
}

# Cognito ユーザープールの作成
resource "aws_cognito_user_pool" "flutter_login_user_pool" {
  name = "flutter_login-user-pool"

  password_policy {
    minimum_length    = 6
    require_lowercase = true
    require_numbers   = false
    require_symbols   = false
    require_uppercase = false
    temporary_password_validity_days = 7
  }

  auto_verified_attributes = ["email"]
}

# Cognito ユーザープールクライアントの作成
resource "aws_cognito_user_pool_client" "my_user_pool_client" {
  name         = "my-user-pool-client"
  user_pool_id = aws_cognito_user_pool.flutter_login_user_pool.id
  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]

  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_scopes = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  callback_urls = ["https://www.example.com/callback"]
  logout_urls = ["https://www.example.com/logout"]
}
