# -*- coding: UTF-8 -*-
	
	u = User.new({
	  username: 'admin',
      email: 'admin@admin.com',
      password: 'admin123',
      password_confirmation: 'admin123'
    })
    u.save
	p "Criando usuario #{u.username}"
