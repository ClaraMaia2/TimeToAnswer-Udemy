namespace :dev do
  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp') # Rails.root -> indica o caminho até a raiz do programa e File.join -> adiciona uma / entre o que está escrito dentro do ()

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") {%x(rails db:drop) }
      show_spinner("Criando BD...") {%x(rails db:create) }
      show_spinner("Migrando BD...") {%x(rails db:migrate) }

      show_spinner("Cadastrando o administrador padrão...") {%x(rails dev:add_default_admin) }
      show_spinner("Cadastrando administradores extras...") {%x(rails dev:add_extra_admins) }
      show_spinner("Cadastrando o usuário padrão...") {%x(rails dev:add_default_user) }

      show_spinner("Cadastrando os assuntos padrões...") {%x(rails dev:add_default_subjects) }

      show_spinner("Cadastrando perguntas e respostas...") {%x(rails dev:add_questions_and_answers) }
      # %x(rails dev:add_)
    else
      puts "Você não está no ambiente de desenvolvimento"
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona administradores extras"
  task add_extra_admins: :environment do
    10.times do |i|
      Admin.create!(
      email: Faker::Internet.email,
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona assuntos padrões"
  task add_default_subjects: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_questions_and_answers: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |i|
        # cadastrando as questões com suas respostas
        params = params_question(subject)
        answers_array = params[:question][:answers_attributes]

        # cadastrando as respostas (todas são incorretas)
        add_answers(answers_array)

        # definindo qual é a resposta correta
        elect_correct_answer(answers_array)

        # criando as questões no banco de dados
        Question.create!(params[:question])
      end
    end
  end

  desc "Reseta contador de assuntos das questões"
  task reset_subject_counter: :environment do
    show_spinner("Resetando contador dos assuntos...") do
      Subject.find_each do |subject|
        Subject.reset_counters(subject.id, :questions)
      end
    end
  end

  private

  # mostrando um spinner quando rodar no terminal o comando rails dev:setup
  def show_spinner(msg_start, msg_end="Concluído")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin

    yield

    spinner.success("#{msg_end}")
  end

  # definindo os parâmetros para as perguntas
  def params_question(subject = Subject.all.sample)
    {
      question:
      {
        description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
        subject: subject,
        answers_attributes: []
      }
    }
  end

  # definindo os parâmetros para as respostas
  def params_answer(correct = false)
    {
      description: Faker::Lorem.sentence,
      correct: correct
    }
  end

  # adicionando respostas
  def add_answers(answers_array = [])
    rand(2..5).times do |j|
      answers_array.push(params_answer)
    end
  end

  # elegendo aleatoriamente qual a resposta certa para uma pergunta
  def elect_correct_answer(answers_array = [])
    index = rand(answers_array.size)
    answers_array[index] = params_answer(true)
  end
end
