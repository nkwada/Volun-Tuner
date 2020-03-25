class SignupMailer < ApplicationMailer
  def send_when_signup(user) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    mail to: user.email, subject: '【Volun-Tuner】 新規登録ありがとうございます'
  end
end
