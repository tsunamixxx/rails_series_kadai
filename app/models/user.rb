class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  before_validation { email.downcase! }
# 保存する前にメールアドレスの値を小文字に変換する方法
# ユーザの値がチェックされる時点で処理を実行したいので、before_validationというコールバックを使います。
# これを使って、ユーザーの値がバリデーション判定される前にemail属性を強制的に小文字に変換します。


  has_secure_password
# ハッシュ関数と言うものを使用して、入力されたものを不可逆(元に戻せない)データにする処理を指します。
# Railsではパスワードのハッシュ化の実装は、has_secure_passwordメソッドを呼ぶ出すだけで、ほとんど完了してしまいます。

# セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカラムに保存する
# 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される
# authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。

  validates :password, presence: true, length: { minimum: 6 }

  has_many :blogs

  has_many :favorites, dependent: :destroy
  has_many :favorite_blogs, through: :favorites, source: :blog
end
