#!/bin/bash
apt-get -y update
apt-get -y install nginx
cat > /var/www/html/index.html <<EOF
<html>
<head><title>Demo</title></head>
<body>
<h1>Hollaatchaboy!!</h1>
Hopefully this demo went well
</body>
</html>
EOF

systemctl nginx enable
systemctl nginx start
