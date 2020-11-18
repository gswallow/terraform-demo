#!/bin/bash
apt-get -y update
apt-get -y install nginx
cat > /var/www/html/index.html <<EOF
<html>
<head><title>Demo</title></head>
<body>
<h1>Holla!!</h1>
You made it!
</body>
</html>
EOF

systemctl nginx enable
systemctl nginx start
