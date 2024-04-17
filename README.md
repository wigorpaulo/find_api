# README

* Instalação do banco de dados postgres, local no Linux Ubuntu

  - link para consulta: https://www.postgresql.org/download/linux/ubuntu/
    https://www.youtube.com/watch?v=q0r-4etqNf4&ab_channel=WagnerMachadodoAmaral

  * Comandos:


    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    
    sudo apt-get update
    
    sudo apt-get -y install postgresql
    
    sudo apt-get install postgresql-12
    
    sudo systemctl start postgresql
    
    sudo systemctl status postgresql
    
    sudo -u postgres psql
    
    ALTER USER postgres PASSWORD 'postgres';
    
    exit
    
    # Pode conectar no banco local

* Versão Ruby
    
        ruby '3.2.2'
 
* Instalar dependência

        bundle install

* Criação de banco de dados
        
        rails db:create

* Inicialização do banco de dados

        rails db:migrate
        rails db:seed

* Como executar o conjunto de testes

        rspec

    -   Ao final da execução do RSPEC poderar verificar a cobertura dos testes por meio da abertura do html INDEX do covarage:
           
                coverage/index.html

* Como executar o rubocop

        rubocop

* Collection para importa no POSTMAN

        ../find_api/cep_api_two/cep_api.postman_collection.json

# Projeto tem como incentivo  a solução do teste técnico: 


### API Consulta CEP

Elaborar uma API REST que retorne os dados de um endereço conforme o CEP informado. Considere que essa API terá um alto volume de acesso.

#### Requisitos
- Linguagem utilizada: Ruby.
- Endpoint para gerar token a partir de um email e senha.
- Endpoint busca o cep e retorna: endereço, bairro, cidade, UF e o endereço completo.
- Salvar os ceps e endereços no banco de dados vinculando o endereço com o usuário que solicitou a consulta

#### O que será avaliado
- Organização do código
- Testes
- **Preocupação com performance**

#### Observações
- Não é necessário elaborar o cadastro do usuário, um seed com a criação do usuário já é o suficiente.
- Utilize qualquer serviço de cep que preferir. Existe o http://cep.la caso não conheça nenhum.
- Subir o projeto em um repositório no Github.
- Caso tenha dúvidas fique à vontade para perguntar.
- README explicando como instalar e rodar sua aplicação.

## Explicação sobre as abordagem utilizada no desenvolvimento do projeto

#### - Linguagem ruby:

- Foi escolhido a versão 3.2.2 tendo em vista de uma das versões mais recente do ruby.

#### - Endpoint para gerar token a partir de um email e senha:

- Foi descido a implementação manual do método que gera o token, pensando em obter uma maior agilidade e controle da
maneira que é gerado o token e na manutenibilidade do código, onde é retirado a dependência e complexidade da
biblioteca de terceito.

#### - Endpoint busca o cep e retorna: endereço, bairro, cidade, UF e o endereço completo:

- Foi implementado a criação da pasta **services** e dentro desta pasta a criação também da pasta **api** e finalmente a
criação do arquivo **find_zip_code_services.rb** que conterá o método **find** que espera um  parametro **zip_code**, para 
poder utilizar no consumo da API **viacep.com** sendo uma api gratuita, para obter as informações esperada de retorno: 
endereço, bairro, cidade, UF e o endereço completo;
- Foi criado um model/tabela chamada **ZipCode** com o intuido de gravar os dados de retorno obtido da API **viacep.com**, 
pensando em evitar o consulmo da API caso já tenho feito uma busca para o CEP desejado anteriormente. 
 
Por exemplo:

  * Faz a consulta do CEP: 74463500 do dia 01/01/2024;
  * No dia 20/01/2024 faz a consulta do CEP:74463500

Conforme mostrado no exemplo, o CEP 74463500 foi executado a consulta 2 vezes, baseado nisso, o sistema busca primeiro 
na tabela **zip_codes** do sistema para verificar se existe já cadastrado, caso tenha, faz o retorno do dado. Com isso, 
A API de busca CEP retorna mais rapidamente os dados e só executa o consumo da API 'viacep.com' desnecessaria.

- Foi criado a model **UserRequestZipCode** para gravar o usuário que fez a requisição e o cep que foi feito a consulta;
- Foi implementado para retorna os dados endereço, bairro, cidade, UF e o endereço completo, com as chaves
em Português ou Inglês, dependendo da configuração da linguagem definida no sistema. Pois o sistema foi desenvolvido
pensando em ser multi-linguagem.

#### - Organização do código:

- Foi configurado o rubocop, com o intuito de deixar o código mais organizado e obdecendo o padrão da comunidade ruby e
clean code, deixando o codigo mais limpo possivel;
- Foi configurado o I18n para deixar o projeto multi-linguagem.

#### - Testes:

- Foi configurado a gema rspec para montar os testes unitários;
- Foi configurado a gema simplecov para poder ter a visibilidade da cobertura dos testes unitários do projeto.

#### - Preocupação com performance:

- A implementação da tabela **zip_codes** pensando em ser mais rapido eu buscar um dados cadastrado na minha base de dados
ser mais rapido, do que consumir uma API.

#### - Implementação bônus:

- Feito a implementação de um Endpoint que retorna todos os usuários existentes no banco de dados.