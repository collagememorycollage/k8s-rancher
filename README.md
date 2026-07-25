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

Также втури скрипта применяется правило, для того, чтобы Virtual Box мог создавать любой диапазон портов.
Так как обычно можно создовать подсети 192.168.56.0/21

При усливии, елси будет возникать ошибка при запуске vagraqnt, то можно попробовать пересобрать модули ядра virtualbox

Пример оишбки:

```
root@neptun-System-Product-Name:/home/neptun/devops_menti/k8s-rancher# vagrant up
Bringing machine 'workerNode' up with 'virtualbox' provider...
Bringing machine 'masterNode' up with 'virtualbox' provider...
Bringing machine 'DNS' up with 'virtualbox' provider...
Bringing machine 'Ansible' up with 'virtualbox' provider...
==> workerNode: Checking if box 'bento/ubuntu-20.04' version '202407.23.0' is up to date...
==> workerNode: Clearing any previously set network interfaces...
There was an error while executing `VBoxManage`, a CLI used by Vagrant
for controlling VirtualBox. The command and stderr is shown below.

Command: ["hostonlyif", "create"]

Stderr: 0%...NS_ERROR_FAILURE
VBoxManage: error: Failed to create the host-only adapter
VBoxManage: error: VBoxNetAdpCtl: Error while adding new interface: failed to open /dev/vboxnetctl: No such file or directory
VBoxManage: error: Details: code NS_ERROR_FAILURE (0x80004005), component HostNetworkInterfaceWrap, interface IHostNetworkInterface
VBoxManage: error: Context: "RTEXITCODE handleCreate(HandlerArg*)" at line 105 of file VBoxManageHostonly.cpp
```

```
sudo rcvboxdrv setup
```
Псле успешного запуска виртуальных машин можно дать комманду vagrant status, чтобы убедиться, что все успешно запущено
```
root@neptun-System-Product-Name:/home/neptun/devops_menti/k8s-rancher#vagrant status 
Current machine states:

workerNode                running (virtualbox)
masterNode                running (virtualbox)
DNS                       running (virtualbox)
Ansible                   running (virtualbox)

This environment represents multiple VMs. The VMs are all listed
above with their current state. For more information about a specific
VM, run `vagrant status NAME`.
```


