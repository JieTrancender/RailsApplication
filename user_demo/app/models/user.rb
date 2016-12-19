class User < ApplicationRecord
    has_secure_password

    before_create{generate_token(:auth_token)}

    #姓名和邮箱必须填写
    validates :name, :email, presence: true

    #唯一且忽略大小写
    validates :name, :email, uniqueness: {case_sensitive: false}

    def generate_token(column)
        begin
            self[column] = SecureRandom.urlsafe_base64
        end while User.exists?(column => self[column])
    end
end
