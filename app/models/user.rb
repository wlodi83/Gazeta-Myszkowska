require 'digest/sha2'
class User < ActiveRecord::Base
  attr_protected :hashed_password, :enabled
  attr_accessor :password

  
  validates_presence_of :username, :email, :message => "Pole nie może być puste!"
  validates_presence_of :password, :message => "Pole nie może być puste!", :if => :password_required?, :message => "Pole nie może być puste!"
  validates_presence_of :password_confirmation, :message => "Pole nie może być puste!", :if => :password_required?
  
  validates_confirmation_of :password, :message => "Hasło jest niepoprawne!", :if => :password_required?
  
  validates_uniqueness_of :username, :case_sensitive => false, :message => "Podana nazwa użytkownika istnieje już w systemie!" 
  validates_uniqueness_of :email, :case_sensitive => false, :message => "Podany email istnieje już w systemie!" 
  validates_format_of :email,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
                      :message => "np. jacek.we@wp.pl"
  validates_length_of :username, :within => 3..64, :message => "Minimum 3 znaki, maksimum 64 znaki"
  validates_length_of :email, :within => 5..128, :message => "Minimum 5 znakówm, maksimum 128 znaków"
  validates_length_of :password, :within => 4..20, :if => :password_required?, :message => "Minimum 4 znaki, maksimum 20 znaków"
  validates_length_of :profile, :maximum => 1000, :message => "Maksimum 1000 znaków"
  
  has_and_belongs_to_many :roles
  has_many :articles
  has_many :entries
  has_many :comments
  
  def before_save
    self.hashed_password = User.encrypt(password) if !self.password.blank?
  end
  
  def password_required?
    self.hashed_password.blank? || !self.password.blank?
  end
  
 
  
  def self.encrypt(string)
    return Digest::SHA256.hexdigest(string)
  end
  
  def self.authenticate(email, password)
    find_by_email_and_hashed_password_and_enabled(email, User.encrypt(password), true )
  end
  
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
end
