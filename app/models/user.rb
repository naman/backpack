class User < ActiveRecord::Base
	validates :name, uniqueness: true
	
	def self.from_omniauth(auth)
		where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid=auth.uid
			user.name = auth.info.name
			user.oauth_token = auth.credentials.oauth_token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end		
	end
		has_many :posts
	# has_many :votes, dependent: :destroy
end
