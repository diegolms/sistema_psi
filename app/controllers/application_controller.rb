class ApplicationController < ActionController::Base
    
	protect_from_forgery with: :null_session
	before_action :authenticate_user!
	
	
	private


	def after_sign_out_path_for(resource_or_scope)
		p "resource_or_scope #{resource_or_scope}"
		root_path
	end
	
end
