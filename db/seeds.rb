# -*- coding: UTF-8 -*-

   
	u = User.new({
	  username: 'admin',
      email: 'admin@jesusdoportov.com',
      password: 'admin123',
      password_confirmation: 'admin123'
    })
    u.save
	
	#categoria
	a = Categorium.new({nome: 'Manutenção/Reparo'})
    a.save!
	
	a = Categorium.new({nome: 'Mensalidade'})
    a.save!
	
	#Pessoa
	p = Pessoa.new({nome: 'Condomínio', numero: '-'})
    p.save!
	
	p = Pessoa.new({nome: 'Diego', numero: '102'})
    p.save! 
	
	
	c = Caixa.new({valor: 0, user_id: u.id})
	c.save!
	
	
	
	
