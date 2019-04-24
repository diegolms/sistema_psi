# -*- coding: UTF-8 -*-

   
		
	#categoria
	a = Categorium.new({nome: 'Mensalidade'})
    a.save!
	p "Criando categoria #{a.nome}"
		
	a = Categorium.new({nome: 'Manutenção/Reparo'})
    a.save!
	p "Criando categoria #{a.nome}"
	
	
	#Pessoa
	p = Pessoa.new({nome: 'Condomínio', numero: '-'})
    p.save!
	p "Criando pessoa #{p.nome}"
	
	p1 = Pessoa.new({nome: 'Alexandre', numero: '101'})
    p1.save! 
	p "Criando pessoa #{p1.nome}"
	
	p2 = Pessoa.new({nome: 'Diego', numero: '102'})
    p2.save!
	p "Criando pessoa #{p2.nome}"
	
	p1 = Pessoa.new({nome: '-', numero: '201'})
    p1.save!
	p "Criando pessoa #{p.nome}"
	
	p1 = Pessoa.new({nome: '-', numero: '202'})
    p1.save! 
	p "Criando pessoa #{p1.nome}"
	
	p1 = Pessoa.new({nome: '-', numero: '203'})
    p1.save!
	p "Criando pessoa #{p2.nome}"
	
	p1 = Pessoa.new({nome: 'Virgílio', numero: '204'})
    p1.save!
	p "Criando pessoa #{p.nome}"
	
	p1 = Pessoa.new({nome: '-', numero: '301'})
    p1.save! 
	p "Criando pessoa #{p1.nome}"
	
	p1 = Pessoa.new({nome: 'Amanda', numero: '302'})
    p1.save!
	p "Criando pessoa #{p2.nome}"
	
	p1 = Pessoa.new({nome: '-', numero: '303'})
    p1.save! 
	p "Criando pessoa #{p1.nome}"
	
	p1 = Pessoa.new({nome: 'Silvia', numero: '304'})
    p1.save!
	p "Criando pessoa #{p2.nome}"
	
	
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
	  p "Criando perfil #{profile.nome}"
    end
	
	u = User.new({
	  username: 'admin',
      email: 'admin@jesusdoportov.com',
      password: 'admin123',
      password_confirmation: 'admin123',
	  perfil_id: 1,
	  pessoa_id: p.id
    })
    u.save
	p "Criando usuario #{u.username}"
	
	c = Caixa.new({valor: 0, user_id: u.id})
	c.save!
	
		
	u = User.new({
	  username: 'diegolms',
      email: 'lmsilva.diego@gmail.com',
      password: 'diegolms123',
      password_confirmation: 'diegolms123',
	  perfil_id: 2,
	  pessoa_id: p2.id
	  })
    u.save
	p "Criando usuario #{u.username} - pessoa #{u.pessoa.nome}"
	
=begin v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
     data_vencimento: Time.now,
     status: 2,
	  valor: 150
    })
    v.save
	
	p "Criando vencimento #{v.user.pessoa.nome}"
	
	v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 1,
	  valor: 150
    })
    v.save
	
	p "Criando vencimento #{v.user.pessoa.nome}"
	
	
	u = User.new({
	  username: 'anapaula123',
      email: 'anapaula@gmail.com',
      password: 'anapaula123',
      password_confirmation: 'anapaula123',
	  perfil_id: 2,
	  pessoa_id: p2.id
    })
    u.save
	
	p "Criando usuario #{u.username} - pessoa #{u.pessoa.nome}"
	

	v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 3,
	  valor: 150
    })
    v.save
	
	p "Criando vencimento #{v.user.pessoa.nome}"
	
	v = Vencimento.new({
	  user_id: u.id,
      data: Time.now.beginning_of_month,
      data_vencimento: Time.now,
      status: 1,
	  valor: 150
    })
    v.save
	
	p "Criando vencimento #{v.user.pessoa.nome}"
=end	
	
