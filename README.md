sudo apt-get update -y && sudo apt-get upgrade -y

wget https://github.com/joohoi/acme-dns-certbot-joohoi/raw/master/acme-dns-auth.py
chmod +x acme-dns-auth.py
vim acme-dns-auth.py #python3
sudo mv acme-dns-auth.py /etc/letsencrypt/
sudo certbot certonly --manual --manual-auth-hook /etc/letsencrypt/acme-dns-auth.py --preferred-challenges dns --debug-challenges -d \*.jonguz.xyz -d jonguz.xyz
# create acme challenge dns CNAME record 

sudo apt install nginx
# sudo vim /etc/nginx/sites-available/default
# https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/linux-nginx?view=aspnetcore-7.0&tabs=linux-ubuntu#https-configuration
sudo vim /etc/nginx/proxy.conf
sudo vim /etc/nginx/nginx.conf
sudo service nginx start
systemctl status nginx.service

# dotnet publish -r linux-x64 --configuration Release -p:PublishSingleFile=true -p:PublishReadyToRun=true --self-contained -p:PublishTrimmed=true
# scp -r .\bin\Release\net6.0\linux-x64\publish\ jonguz@52.149.165.176:/home/jonguz/myapp

cd ~/myapp/
chmod +x myapp
./myapp &

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh from #.#.#.#
sudo ufw allow https
sudo ufw allow 'Nginx Full'
sudo ufw enable