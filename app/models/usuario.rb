class Usuario < ActiveRecord::Base
  attr_accessible :email, :nombre, :password_digest
  has_secure_password
end
