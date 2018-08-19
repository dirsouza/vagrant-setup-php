Vagrant-Setup
===========

Servidor LAMP (Linux, Apache, MySQL, PHP)

Configuração do Vagrant (com provisionamento em Shell Script) para criar uma máquina virtual (Ubuntu Server 18.04 64 Bits) de desenvolvimento em PHP.

### Pacotes Inclusos:

- PHP 7.2
- MySQL 5.7
- Git
- Composer
- cURL
- Vim
- Redis
- Nmp
- Vue-cli
- Virtualhosts
(Para mais detalhes consulte arquivo setup.sh)


Você vai precisar: 
==============

- Virtualbox - https://www.virtualbox.org/
- Vagrant - http://www.vagrantup.com/
- Git - http://git-scm.com ( Opicional )
- Acesso Internet


-> Instale o Virtualbox e o Vagrant de acordo com seu sistema operacional. ( A instalação é bem simples e pode ser feita sem muitas dificuldades... )


Modo de Uso
===========

A instalação inicial pode ser feita de duas formas, sendo:

1º -> Caso tenha o Git instaldo em sua máquina, proceda da seguinte forma:



* Clone esse repositório para sua máquina:

- git clone https://github.com/dirsouza/vagrant-setup-php.git ( Execute o comando no seu Prompt/Terminal )

* Ainda no Prompt de comando/Terminal Entre no diretório vagrant-setup-php  ( Ou o que você definir na hora da clonagem )

* Inicie a máquina virtual com o comando:

- vagrant up 




2º -> Caso não tenha o Git instalado em sua máquina, acesse https://github.com/dirsouza/vagrant-setup-php baixe o arquivo do projeto no formato .zip e descompacte-o onde desejar.

* Abra seu Prompt/Terminal , acesse o diretorio que acabou de descompactar e rode o comando:

- vagrant up




Após este comando 'vagrant up', o Vagrant ficará responsavel por baixar o sistema operacional ( neste caso Ubuntu Server 18.04 x64 ), configurar a máquina virtual no VirtualBox e posteriormente baixar, instalar e configurar todos os pacotes do script 'setup.sh' e 'virtualhosts.sh' (Lembre-se, para o virtualhosts proceder de forma correta, o seu projeto já deve está dentro da pasta 'projetos').

Quando tudo estiver pronto, um servidor web estará disponível no endereço http://localhost:8080, e a instalação do PHPMyAdmin está em http://localhost:8080/phpmyadmin, para acessar utilize:

- Login: root
- Senha: root

Obs.: Para ter acesso pelo Workbench, basta confirmar a porta que foi setada para a porta padrão do MySQL 3306, por padrão é a mesma porta 3306, para saber qual porta está sendo setada, basta olhar os setups de inicialização do vagrant em:

- default: Forwarding ports...
- default: 3306 (guest) => 3306 (host) (adapter 1), onde 'guest' é porta do MySQL no vagrant e o 'host' é porta de acesso ao MySQL fora do vagrant.

- Connection Method: Standard (TCP/IP)
- Hostname: 127.0.0.1
- Port: 3306
- Username: root
- Password: root


Coloque seu código no diretório "projetos". Todo o conteúdo dele estará disponível via http://localhost:8080. (Como teste, já existe um arquivo index.php que chama a função phpinfo() ).

Lembrete
===========
Após rodar seu vagrant, é uma boa prática comentar as linhas 'config.vm.provision...', evitando executar os '.sh' sempre, e quando fizer alguma modificação no 'setup.sh' ou 'config.sh', como por exemplo adicionar uma virtualhost ou banco de dados, descomentar a linha, poderar ser necessário após subir o 'vagrant up', executar o 'vagrant reload --provision', nesse caso não comente a linha ainda.

Para desligar a máquina virtual utilize o comando:

- vagrant halt

Para religar novamente utilize:

- vagrant up

Caso queira destruir a máquina virtual (o conteúdo do projetos não será excluido):

- vagrant destroy
