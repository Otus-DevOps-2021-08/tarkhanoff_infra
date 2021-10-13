# tarkhanoff_infra
tarkhanoff Infra repository

# Домашнее задание 1-5 (cloud-bastion)

Для того, чтобы подключиться к **someinternalhost** через **bastion** в одну команду, можно использовать возможность удалённого выполнения команды через SSH. Например, так:

    ssh -A -t appuser@<bastion_ext_IP> "ssh appuser@<inthost_int_IP>"

Ключ -A пробрасывает соединения с ssh-agent для аутентификации на целевой машине с помощью локального ключа, а -t нужен для создания псевдо-терминала.

Но более корректным вариантом мне кажется использование ProxyJump опции:

    ssh -J appuser@<bastion_ext_IP> appuser@<inthost_int_IP>

Подключение к этим хостам можно упростить, используя Aliases. Для этого нужно в файл ~/.ssh/config добавить следующее:

    Host bastion
        HostName <bastion_ext_IP>
        User appuser

    Host someinternalhost
        Hostname <inthost_int_IP>
        User appuser
        ProxyJump appuser@<bastion_ext_IP>

Тогда можно будет подключаться с использованием команд вида

    ssh bastion
    ssh someinternalhost

Для доступа к внутренним ресурсам можно использовать VPN.

    Файл конфига для OpenVPN - cloud-bastion.ovpn
    Логин - test
    Пароль - 6214157507237678334670591556762

bastion_IP = 62.84.112.99

someinternalhost_IP = 10.128.0.7

# Домашнее задание 2-6 (cloud-testapp)

В процессе выполнения домашнего задания была создана ВМ и на ней было развёрнуто тестовое приложение.

testapp_IP = 178.154.240.104

testapp_port = 9292

Дополнительное задание:

Можно автоматизировать развёртывание приложения, используя cloud-init и метаданные. Для этого нужно выполнить такую команду:

    yc compute instance create \
        --name reddit-app-auto \
        --hostname reddit-app-auto \
        --memory=4 \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
        --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
        --metadata-from-file user-data=./reddit-app-metadata.yaml

В файле reddit-app-metadata.yaml содержится описание конфигурации ВМ, которое будет подхвачено cloud-init.
