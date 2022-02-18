#!/bin/bash
sudo su
apt-get update
apt-get install -y squid nginx git
sed -i "s/^http_port.*/http_port 1234 transparent/g" /etc/squid/squid.conf
sed -i "s/^http_access\ deny.*/http_access\ deny\ all/g" /etc/squid/squid.conf
sed -i 's/^acl\ allowed_http_sites.*/acl allowed_http_sites dstdomain\ "\/etc\/squid\/whitelist.txt/g"' /etc/squid/squid.conf
sed -i "s/^http_access\ allow.*/http_access\ allow\ allowed_http_sites/g" /etc/squid/squid.conf
echo "azure.microsoft.com\ngoogle.com\napple.com\npaytm.com\naws.amazon.com" >> /etc/squid/whitelist.txt
sudo systemctl restart squid
sudo iptables -t nat -A PREROUTING -p tcp --dport 1234 -j REDIRECT --to-port 80
git clone https://github.com/feedmepos/devops-take-home-assignment.git
nginx.conf <<-EOF user       www www;  ## Default: nobody
worker_processes  5;  ## Default: 1
error_log  logs/error.log;
pid        logs/nginx.pid;
worker_rlimit_nofile 8192;

events {
  worker_connections  4096;  ## Default: 1024
}

http {
  include    conf/mime.types;
  include    /etc/nginx/proxy.conf;
  include    /etc/nginx/fastcgi.conf;
  index    index.html index.htm index.php;

  default_type application/octet-stream;
  log_format   main '$remote_addr - $remote_user [$time_local]  $status '
    '"$request" $body_bytes_sent "$http_referer" '
    '"$http_user_agent" "$http_x_forwarded_for"';
  access_log   logs/access.log  main;
  sendfile     on;
  tcp_nopush   on;
  server_names_hash_bucket_size 128; # this seems to be required for some vhosts

  server { # simple reverse-proxy
    listen       80;
    server_name  secnet.com www.secnet.com;
    access_log   logs/secnet.access.log  main;

    # serve static files
    location ~ ^/(images|javascript|js|css|flash|media|static)/  {
      root    /var/www/secnet;
      index   index.html;
      expires 30d;
    }

  }

}
EOF
sudo mv -f nginx.conf /etc/nginx/nginx.conf
cp frontend/index.html /var/www/secnet/index.html
sudo systemctl restart nginx