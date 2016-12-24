class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email, :message => "Please enter email"
  # validates_presence_of :password, :message => "Please enter email"
  validates_presence_of :first_name, :message => "Please enter first name"
  validates_presence_of :last_name, :message => "Please enter last name"

  before_create :generate_promocode

  def generate_promocode
    promocode = Digest::SHA1.hexdigest(BCrypt::Engine.generate_salt)
    self.promocode = promocode.first(6)
  end

end
