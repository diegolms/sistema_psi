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
		
      end
    end
  end

  task :systemSetDefaultConfig => :environment do
    config = SystemConfig.new
    config.installed = 1
    config.save
  end

  task :reinstall => :environment do

	p "apaga o banco de dados"
    Rake::Task["db:drop"].invoke

    p "Cria o banco de dados"
    Rake::Task["db:create"].invoke
		
    p "Executa os migrations"
    Rake::Task["db:migrate"].invoke

    p "Cadastra usuario administrador"
    Rake::Task["app:criar_usuario_administrador"].invoke

	p "Seta System Default"
    Rake::Task["app:systemSetDefaultConfig"].invoke

  end

  # Criar usuário
  task :criar_usuario_administrador => :environment do

	u = User.new({
	  username: 'admin',
      email: 'admin@jesusdoportov.com',
      password: 'admin',
      password_confirmation: 'admin'
    })
    u.save
  end
  
end

