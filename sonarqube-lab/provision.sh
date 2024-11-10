#!/bin/bash

# Atualiza sistema
sudo apt update

# Adiciona usuário para executar sonarqube
sudo useradd sonar

# baixa java
sudo apt install openjdk-17-jdk -y
# baixa wget
sudo apt install wget -y
# baixa unzip
sudo apt install unzip -y

# baixa sonarqube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.7.0.96327.zip
# descompacta unzip
unzip sonarqube-10.7.0.96327.zip -d /opt/
# renomeia
mv /opt/sonarqube-10.7.0.96327 /opt/sonarqube
# permite usuário alterar diretório
chown -R sonar:sonar /opt/sonarqube
# criar serviço para ser startado automaticamente
touch /etc/systemd/system/sonar.service
echo > /etc/systemd/system/sonar.service

cat <<EOT >> /etc/systemd/system/sonar.service
[Unit]
Description=Sonarqube service
After=syslog.target network.target
[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux=x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux=x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
[Install]
WantedBy=multi-user.target
EOT

service sonar start