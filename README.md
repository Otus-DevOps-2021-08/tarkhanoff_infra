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
