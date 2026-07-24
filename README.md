k8s-rancher

Для настройки базового окружения можно воспользоваться скриптом ./install.sh, который установит VirtualBox и vgrant

Также перед началом работы, следует настроить 3x-ui, чтобы использовать прокси. При условии, что вы находитесь в регионе RU.

```
touch .env
echo "https_proxy=http://login:pass@ip_server_proxy:port" > .env
```

```
chmod +x ./install.sh
./install.sh
```


