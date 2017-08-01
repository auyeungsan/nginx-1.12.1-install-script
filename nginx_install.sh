#!/bin/bash

echo 'Add user and group'
groupadd -g 497 nginx
useradd -u 497 -g nginx -d /var/lib/nginx -M -s /sbin/nologin -c 'Nginx web server' nginx
echo 'Done!'
sleep 3
echo 'Yum install extra package'
yum install -y epel-release
yum install -y git
yum install -y wget
yum install -y gcc pcre pcre-devel openssl openssl-devel GeoIP GeoIP-devel GeoIP-data libxml2-devel libxslt-devel libraries-devel gd-devel gd perl-ExtUtils-Embed
sleep 3
echo 'Done!'
echo 'Download Nginx and other module'
cd /opt/
wget https://nginx.org/download/nginx-1.12.1.tar.gz
git clone https://github.com/FRiCKLE/ngx_cache_purge.git
git clone https://github.com/auyeungsan/Nginx-init-script.git
echo 'Done!'
sleep 3
echo 'Start install nginx'
tar -vxzf nginx-1.12.1.tar.gz
cd nginx-1.12.1
./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/var/run/nginx.pid --lock-path=/var/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-debug --add-module=/opt/ngx_cache_purge --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic' --with-ld-opt=' -Wl,-E' 
make && make install
cp /opt/Nginx-init-script/nginx /etc/init.d/
chmod 755 /etc/init.d/nginx
chkconfig --add nginx
chkconfig nginx on
echo 'Done!'
sleep 3
echo 'install finished!'