#!/bin/bash
apt-get update
apt-get -y install curl
apt-get update && apt-get install -y package-bar
apt install -y cron
apt install -y docker.io
apt install -y docker-compose



groupadd developers
groupadd web
groupadd marketing
groupadd docker
groupadd figma
groupadd ads

##Création de 5 utilisateurs
#le premier utilisateur est Développeur #1 Commentaire : software engineer Dossier utilisateur : /engineers/developer1 Date d’expiration du compte : 1er janvier 2050 Groupe● developers● docker■ Compte système ? Oui■ Identifiant : 1000
useradd -c "software engineer" -d /engineers/developer1 -e 2050-01-01 -G developers,docker -s /bin/bash -u 1000 developer1

#le deuxième utilisateur  Développeur #2 
useradd -c "software engineer" -d /engineers/developer2 -e 2050-01-02 -G developers,docker -s /bin/bash -u 1001 developer2

#le troisième  un Intégrateur #1
useradd -c "integrator" -d /web/integrator1 -e 2060-02-01 -G web,figma -s /bin/bash -u 2000 integrator1

#le quatrième  un Intégrateur #2
useradd -c "integrator" -d /web/integrator2 -e 2060-02-02 -G web,figma -s /bin/bash -u 2001 integrator2

#le cinquième  unGrowth Hacker
useradd -c "growthhacker" -d /marketing/growthhacker -e 3000-03-01 -G marketing,ads -s /bin/bash -u 3000 growthhacker

#afficher les utilisateurs avec leurs commentaires
#cat /etc/passwd | cut -d: -f1,5 | tr : " " | sort -k2
cat /etc/passwd


##Permissions
#on crée un dossier development et notre fichier index.html
mkdir /development
touch /development/index.html
touch /development/index.css


##on donne( il appartient) le fichier à l’utilisateur developer1 et on lui donne tous les droits (rwx)
chown developer1:developers /development/index.html
chmod 750 /development/index.html

#Pour les autres
# Le fichier est accessible uniquement en lecture seule (r--)
chmod o+r /development/index.html


##pour le fichier index.css
chown integrator1:web /development/index.css
chmod 750 /development/index.css

#Pour les autres
#aucun droit
chmod o-r /development/index.css


##afficher les permissions du dossier development
ls -l /development

####BONUS
#Sauvegarde des dossiers utilisateurs tous les jours à 3h30 du matin dans le dossier /root
#30 minutes et 3 heure
echo "30 3 * * * root cp -r /engineers /root" >> /etc/cron.d/crontab
echo "30 3 * * * root cp -r /web /root" >> /etc/cron.d/crontab
echo "30 3 * * * root cp -r /marketing /root" >> /etc/cron.d/crontab





#affiche les tâches planifiées
crontab  -l
#for user in $(getent passwd | cut -f1 -d: ); do echo $user; crontab -u $user -l; done





##DOCKER
# Création du répertoire /backup s'il n'existe pas
systemctl start docker


# Copie des fichiers de sauvegarde vers le répertoire /data du deuxième conteneur
docker cp /root/engineers ubuntu2:/backup/
docker cp /root/web ubuntu2:/backup/
docker cp /root/marketing ubuntu2:/backup/


