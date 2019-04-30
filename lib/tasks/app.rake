# -*- encoding : utf-8 -*-

namespace :app do

  task :install => :environment do

    config = SystemConfig.first

    unless config.nil?
      if config.installed == false
        p "Cria o banco de dados"
        Rake::Task["db:create"].invoke
		
        p "Executa os migrations"
        Rake::Task["db:migrate"].invoke

        p "Cadastra usuario administrador"
        Rake::Task["app:criar_usuario_administrador"].invoke

		p "Seta System Default"
        Rake::Task["app:systemSetDefaultConfig"].invoke
		
		Rake::Task["db:seed"].invoke
		
      end
    end
  end

  task :systemSetDefaultConfig => :environment do
    config = SystemConfig.new
    config.installed = 1
    config.save
  end

  task :reinstall => :environment do
	
	 Rake::Task["db:drop"].invoke

    # Cria o banco de dados
    Rake::Task["db:create"].invoke

    # Executa os migrations
    Rake::Task["db:migrate"].invoke

    Rake::Task["db:seed"].invoke

    Rake::Task["app:systemSetDefaultConfig"].invoke

  end
  
  task :popular_base => :environment do
	
    # Executa os migrations
    Rake::Task["db:migrate"].invoke

    Rake::Task["db:seed"].invoke

    Rake::Task["app:systemSetDefaultConfig"].invoke

  end

  # Criar usuário
  #task :criar_usuario_administrador => :environment do

	#u = User.new({
	#  username: 'admin',
   #   email: 'admin@jesusdoportov.com',
    #  password: 'admin',
   #   password_confirmation: 'admin'
   # })
  #  u.save
 # end
 
	  # Criar Vencimentos
	  # rake app:criar_vencimento_usuarios valor=150 dia=1  
  task :criar_vencimento_usuarios => :environment do

	 valor = ENV['valor']
	
     dia = ENV['dia']
	 
	 if (dia.to_i) > 0
		data = (Time.now + (dia.to_i).day).beginning_of_month
	 else
		data = Time.now.beginning_of_month
	 end
	 
	 Pessoa.where("id != 1").each do |pessoa|
	 
  		 v = Vencimento.new({
		  pessoa_id: pessoa.id,
		  data: data,
		  data_vencimento: Time.now.beginning_of_month + 14.day,
		  status: 1,
		  valor: valor
		 })
		 v.save
	 end
	  
	end 
  
end

