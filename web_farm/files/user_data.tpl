apt-get -y install nginx
cat > /var/www/nginx/index.html <<EOF
<html>
<head><title>Demo</title></head>
<body>
<h1>Hello, Tekniholiks!</h1>
Hopefully this demo went well
</body>
</html>
EOF

systemctl nginx enable
systemctl nginx start
