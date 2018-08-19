#!/bin/bash

echo "--- Criar Virtualhost ---"

# Comandos básicos
# sudo sh virtualhost [create | delete] [dominio] [diretório]
# Exemplo:
    # sudo virtualhost create mysite.dev html/mysite/public
    # sudo virtualhost delete mysite.dev html/mysite
        # pasta "html" - essa pasta é padrão do apache em /var/www
        # pasta "mysite" - essa pasta é a pasta raiz do seu projeto
        # pasta "public" - essa pasta é a pasta pública do seu projeto, onde contem seu index.* e o .htaccess

echo "--- Virtual Host ---"
#sudo virtualhost create mysite.com html/api/public


echo "--- Criar Banco de Dados ---"
# Comandos básicos
# mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS [nome database];"
# Exemplo:
    # mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS mysite;"

echo "--- Database ---"
#mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS mysite;"

