
# Actualiza os repositorios  
zypper refresh

# Cambia a configuración do LOCALE
localectl set-locale LANG=es_ES.UTF-8 
localectl set-keymap es 

# Configura NTP
zypper --non-interactive install chrony-pool-openSUSE 
systemctl start chronyd.service 
systemctl enable chronyd.service 

# Configura o nome da VM usando o argumento que lle pasamos ao script
hostnamectl hostname $1 

# Instale CRM e as súas dependencias, entre elas Corosync e Pacemaker
zypper --non-interactive install crmsh 

# Añade a IP e o nome de cada VM do cluster no ficheiro

# Se non hai entradas de execucións previas 
if [[ ! $(grep "192.168.56" "/etc/hosts") ]]; then 
    # Inserir as liñas iniciais  
    echo >> /etc/hosts 
    echo "# mfm2425-cluster" >> /etc/hosts 
else 
    # Eliminar as entradas de execucións previas 
    sed -i "/192.168.56/d" /etc/hosts 
fi 
echo "192.168.56.2  mfm2425-master" >> /etc/hosts 
echo "192.168.56.3  mfm2425-slave" >> /etc/hosts  
echo "192.168.56.4  mfm2425-spare" >> /etc/hosts 