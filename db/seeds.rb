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
	
	
	
	
	
