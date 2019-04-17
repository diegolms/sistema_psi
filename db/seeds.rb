# -*- coding: UTF-8 -*-

   
		
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
	
	
	u = User.new({
	  username: 'diegolms',
      email: 'lmsilva.diego@gmail.com',
      password: 'diegolms123',
      password_confirmation: 'diegolms123',
	  perfil_id: 2,
	  pessoa_id: p.id
	  })
    u.save
		
	#Criando perfil
	profiles = ['Administrador', 'Usuário']

	i = 0
    profiles.each do |p|
      name = p
      profile = Perfil.new
      profile.nome = name
	  profile.codigo = (i = i +1)
      profile.status = 1
	  profile.descricao = name
      profile.save
    end
	
	u = User.new({
	  username: 'admin',
      email: 'admin@jesusdoportov.com',
      password: 'admin123',
      password_confirmation: 'admin123',
	  perfil_id: 1
    })
    u.save
	
	c = Caixa.new({valor: 0, user_id: u.id})
	c.save!
	
	  u = User.new({
	  username: 'diegolms',
      email: 'lmsilva.diego@gmail.com',
      password: 'diegolms123',
      password_confirmation: 'diegolms123',
	  perfil_id: 2
    })
    u.save
	
	 v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 2,
	  valor: 150
    })
    v.save
	
	v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 1,
	  valor: 150
    })
    v.save
	
	
	u = User.new({
	  username: 'silvia',
      email: 'silvia@gmail.com',
      password: 'silvia123',
      password_confirmation: 'silvia123',
	  perfil_id: 2
    })
    u.save
	
	
	v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 3,
	  valor: 150
    })
    v.save
	
	v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 1,
	  valor: 150
    })
    v.save
	
	
