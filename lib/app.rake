# -*- encoding : utf-8 -*-

namespace :app do

  task :install => :environment do

    config = SystemConfig.first

    unless config.nil?
      if config.installed == false
        # Cria o banco de dados
        Rake::Task["db:create"].invoke

        # Executa os migrations
        Rake::Task["db:migrate"].invoke

        # Cadastra condôminos
        Rake::Task["app:criar_condominos"].invoke

        # Cadastra usuario administrador
        Rake::Task["app:criar_usuario_administrador"].invoke

        # Cadastra Categoria
        Rake::Task["app:cadastrar_categoria"].invoke

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

    #Rake::Task["db:drop"].invoke

    # Cria o banco de dados
    #Rake::Task["db:create"].invoke

    # Executa os migrations
    Rake::Task["db:migrate"].invoke

    # Cadastra condôminos 
    Rake::Task["app:criar_condominos"].invoke

    # Cadastra usuario administrador
    Rake::Task["app:criar_usuario_administrador"].invoke

    # Cadastra Categoria
    Rake::Task["app:cadastrar_categoria"].invoke

    Rake::Task["app:systemSetDefaultConfig"].invoke

  end

  task :teste => :environment do
    recursos = Controller.includes(:action).references(:action)
    recursos.each do |controller|
      p controller.name
      controller.action.each do |action|
        p action.name
      end
    end
  end

  # Criando perfil
  task :criar_perfil => :environment do

    profiles = ['Master', 'Lojista', 'Gerente', 'Operador', 'Cliente']

    profiles.each do |p|
      name = p
      profile = Profile.new
      profile.name = name
      profile.status = 1
      profile.save
      p "Perfil #{profile.name} criado!"
    end
  end

  task :autenticar_usuario => :environment do

    login = 'yonathalmeida@gmail.com'
    password = 'string'
    user = User.where("login = '#{login}' and password = '#{User.encripitar_senha(password)}'").first

    unless user.nil?
      p 'Correto'
      ap user
    else
      p 'Incorreto'
    end

  end

  # Associando usuário a um perfil
  task :create_user_profile => :environment do

    user = User.find(1)
    profile = Profile.find(1)
    user_profile = UserProfile.new
    user_profile.users_id = user.id
    user_profile.profiles_id = profile.id
    user_profile.save
    p "Registro #{user.login} vinculado ao perfil #{profile.name}"
  end

  # Cria permissão de perfil a controller e action
  task :criar_permissao => :environment do

    # perfis_do_usuario = UserProfile.new
    # perfis_do_usuario.users_id = 1
    # perfis_do_usuario.profiles_id = 1
    # perfis_do_usuario.save

    user = User.find(1)
    profile = Profile.find(1)
    @permission = Permission.new
    @permission.controllers_id = 1
    @permission.actions_id = 7
    @permission.profiles_id = profile.id
    @permission.status = 1
    @permission.save
    p "Permissão ao us-uário #{user.login} concedida ao perfil #{profile.name}"
  end

  task :verificar_permissao => :environment do

    user = User.find(1)

    action = 'index'
    controller = 'user'

    @permissions = Permission.includes({:user_profile => :user}, {:action => :controller}).where("users.id = #{user.id} and actions.name = '#{action}' and controllers.name = '#{controller}'").references(:action, :controllers, :user_profile, :user, :profile).first

    if @permissions
      abort('Aceito')
    else
      abort('Acesso negado')
    end
  end

  task :cadastrar_patrimonios => :environment do
    p1 = Patrimonio.new
    p1.nome = 'Notebook'
    p1.save

    p1 = Patrimonio.new
    p1.nome = 'Mesa'
    p1.save
  end

  task :atualizar_recursos => :environment do


    recursos = []
    cs = Dir.entries("#{Rails.root}/app/controllers/")
    for ctrl in cs
      if ctrl.include? '.rb'
        ctrl = ctrl.sub(/.rb/, '').split('_')
        controller_class = ''
        ctrl.each do |x|
          controller_class << x.capitalize
        end

        recursos << {
            :controller => controller_class.downcase.gsub('controller', ''),
            :actions => Object.const_get(controller_class).action_methods - ApplicationController.action_methods
        }
      end
    end
  end

  task :enviando_codigo_ativacao => :environment do
    usuario = User.find(3)
    p usuario.email
    p usuario.codigo_ativacao
    # if EsicMailer.enviar_codigo_ativacao(usuario.email, usuario.codigo_ativacao).deliver_now
    #   p "Código de ativação #{usuario.codigo_ativacao} enviado para o email #{usuario.email}"
    # end
    EsicMailer.enviar_codigo_ativacao(usuario.email, usuario.codigo_ativacao).deliver
  end


  # Criar usuário
  task :criar_usuario_administrador => :environment do

    user = User.new
    user.login = 'yonathalmeida'
    user.name = 'Yonatha Almeida'
    user.email = 'yonathalmeida@gmail.com'
    user.password = User.encripitar_senha('string')
    user.telefone = '83991732814'
    user.profile_id = Profile.where("name = 'Master'").first.id
    user.status = 1
    if user.save
      " - Usuário #{user.login} criado."

    end
  end

  task :categoria_tipos_oferta => :environment do
    categorias = [
        'Permanente',
        'Temporária'
    ]

    categorias.each do |categoria|
      oferta_cateogira = OfertaCategoria.new
      oferta_cateogira.nome = categoria
      oferta_cateogira.save
    end

    permanente = OfertaCategoria.where("nome = 'Permanente'").first
    temporaria = OfertaCategoria.where("nome = 'Temporária'").first

    p "#{categorias.count} Categorias de tipos de ofertas criadas."

    tipo1 = [
        {
            :nome => 'Cadastrou ganhou',
            :descricao => 'Incentive o cadastro completo do cliente no programa de fidelidade e presenteie com uma recompensa.',
            :categoria => permanente.id,
            :imagem => 'online-shop.svg',
            :hasBeneficio => [1, 2, 3]
        },
        {
            :nome => 'Boomerang',
            :descricao => 'Aumente o retorno de clientes em sua loja. oferta enviada automaticamente logo após uma compra, com validade de resgate curto.',
            :categoria => permanente.id,
            :imagem => 'boomerang.svg',
            :hasBeneficio => [1, 2, 3]
        },
        {
            :nome => 'Aniversariantes',
            :descricao => 'Encante e engaje seus clientes, enviando uma oferta no dia do aniversário deles. Você só precisa ativar essa oferta uma vez!',
            :categoria => permanente.id,
            :imagem => 'cupcake.svg',
            :hasBeneficio => [1, 2, 3]
        },
        {
            :nome => 'Resgatar',
            :descricao => 'Resgate clientes que estão deixando de comprar na loja. A oferta é disparada quando o cliente completa um ciclo de dias sem comprar.',
            :categoria => permanente.id,
            :imagem => 'calendar.svg',
            :hasBeneficio => [1, 2, 3]
        },
    # {
    #     :nome => 'Grupos',
    #     :descricao => '',
    #     :categoria => temporaria.id,
    #     :imagem => ''
    # },
    # {
    #     :nome => 'Direcionada',
    #     :descricao => '',
    #     :categoria => temporaria.id,
    #     :imagem => ''
    # },
    # {
    #     :nome => 'Portal do Consumidor',
    #     :descricao => '',
    #     :categoria => temporaria.id,
    #     :imagem => ''
    # }
    ]

    tipo1.each do |t|
      tipo = OfertaTipo.new
      tipo.nome = t[:nome]
      tipo.descricao = t[:descricao]
      tipo.categoria_id = t[:categoria]
      tipo.imagem = t[:imagem]
      tipo.status = true
      tipo.save

      if t[:hasBeneficio].count() > 0
        t[:hasBeneficio].each do |b|
          oferta_tipo_beneficio = OfertaTipoBeneficio.new
          oferta_tipo_beneficio.tipo_id = tipo.id
          oferta_tipo_beneficio.beneficio_id = b
          oferta_tipo_beneficio.save!
        end
      end

    end


    p "#{tipo1.count} Tipos de ofertas criados"
  end

  task :cadastrar_loja => :environment do
    loja = Loja.new
    loja.nome = "Brasforte"
    loja.razao_social = "Brasforte Suplementos"
    loja.cnpj = '09.008.050/0001-90'
    loja.cep = '49072-290'
    loja.user_id = 1
    loja.save!
  end

  task :oferta_beneficios => :environment do
    beneficios = [
        {
            :nome => 'Grátis',
            :descricao => "O cliente pode resgatar sem necessidade de fazer uma compra de outro produto.",
            :loja_id => 1,
            :imagem => 'gift2.svg'
        }, {
            :nome => 'Desconto',
            :descricao => 'Percentual de desconto a ser dado para compra ou produto específico.',
            :loja_id => 1,
            :imagem => 'bargains.svg'
        }, {
            :nome => 'Compre e ganhe',
            :descricao => 'A oferta está vinculada a uma compra ou produto para ser utilizada.',
            :loja_id => 1,
            :imagem => 'cart.svg'
        }
    ]

    beneficios.each do |beneficio|
      oferta_cateogira = OfertaBeneficio.new
      oferta_cateogira.nome = beneficio[:nome]
      oferta_cateogira.descricao = beneficio[:descricao]
      oferta_cateogira.imagem = beneficio[:imagem]
      oferta_cateogira.loja_id = beneficio[:loja_id]
      oferta_cateogira.save!
    end
  end
end
