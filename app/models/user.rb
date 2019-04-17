class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
		 
  attr_writer :login
  
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  
  belongs_to :perfil, optional: true, class_name: "Perfil", foreign_key: "perfil_id"
  belongs_to :pessoa, optional: true, class_name: "Pessoa", foreign_key: "pessoa_id"
  has_many :vencimentos

  def login
    @login || self.username || self.email
  end
  
  
	def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
		where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
		if conditions[:username].nil?
		  where(conditions).first
		else
		  where(username: conditions[:username]).first
		end
	  end
	end
	
	def isAdmin?
		return self.perfil.codigo == Perfil::ADMIN
	end
	
end
