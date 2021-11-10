echo Install pre-requisites
apt install -y ffmpeg python3.8 python-pip screen
apt-get update -y
apt-get -y install netcat
echo Checking OpenSSL
openssl version -a
echo Generating cert
cd /tmp
openssl ecparam -out /tmp/private.key -name prime256v1 -genkey -noout
openssl req -new -sha256 -key /tmp/private.key -out /tmp/server.csr -subj "/C=TW/L=Taipei/O=Ubiquiti Networks Inc./OU=devint/CN=camera.ubnt.dev/emailAddress=support@ubnt.com"
openssl x509 -req -sha256 -days 36500 -in /tmp/server.csr -signkey /tmp/private.key -out /tmp/public.key
cat /tmp/private.key /tmp/public.key > client.pem
rm -f /tmp/private.key /tmp/public.key /tmp/server.csr
echo Copy SSL Cert
cp /tmp/client.pem /opt/client.pem
echo installing unifi-cam-proxy
pip install unifi-cam-proxy
echo complete
exit 0
