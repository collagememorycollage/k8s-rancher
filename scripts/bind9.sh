#!/bin/sh
sudo apt update && apt-get upgrade -y 
sudo apt install bind9 bind9utils bind9-doc -y

echo "
acl mynet {192.168.41.0/24; 127.0.0.1;};
options {
	directory \"/var/cache/bind\";

	dnssec-validation auto;
	
	allow-query {mynet;};
	listen-on-v6 { none; };
};
" > named.conf.options

echo "
zone \"ex\" {
	type master;
	file \"/etc/bind/fz_ex\";
};

//ip to domain
zone \"41.168.192.in-addr.arpa\" {
	type master;
	file \"/etc/bind/rz_ex\";
};
" > /etc/bind/named.conf.local

touch /etc/bind/fz_ex

echo "
;
; BIND data file for local loopback interface
;
;don't forget empty string end!!!
\$TTL	604800
\$ORIGIN ex.
@	IN	SOA	www admin (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	www.ex.	
@	IN	A	192.168.41.102
www	IN	A	192.168.41.102
wc1	IN	A	192.168.41.100
mn1 	IN	A	192.168.41.101

" > /etc/bind/fz_ex

touch /etc/bind/rz_ex

echo "
;
; BIND data file for local loopback interface
;
\$TTL	604800
\$ORIGIN	41.168.192.in-addr.arpa. 
@	IN	SOA	www.ex. admin.ex. (
			      2		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
		NS	www.ex.	
1	PTR	www.ex.
1	PTR	mn1.ex.
2	PTR	wc1.ex.

" > /etc/bind/rz_ex

echo "nameserver 192.168.41.102" >> /etc/resolv.conf

systemctl reload bind9
