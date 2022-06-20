# Bfmarket

Bfmarket - это веб-сайт для покупок на основе микросервисов, написанный на Python и Go, развернутый на Kubernetes с помощью werf. 

Приложение состоит из следующих сервисов:

Frontend для обслуживания пользователей.
Carts обрабатывает корзины пользователей и сохраняет их в Redis.
Product хранит все товары, используя Postgres.
Checkout организует оформление заказа.
Email отправляет электронное письмо пользователю.
Shipping генерирует идентификатор доставки.
Payment генерирует идентификатор транзакции.

![](/microsvc.png)

**Используемые инструменты/фреймворки:**

Gin для создания REST API
Starlette как асинхронный веб-сервер Python
Redis как база данных корзин покупателей.
PostgreSQL как база данных товаров.

## Инфраструктура

Приложение основано на docker контейнерах и развернуто в кластере Kubernetes. Вся инфраструктура основана на принципах «Infrastructure as Code» с использованием Kubernetes и Ansible.

**Используемые технологии и инструменты:**

Kubernetes
kubeadm
Helm
Ingress nginx
Docker
Jenkins, werf
Ansible

С помощью Ansible развертывается кластер Kubernetes с nginx ingress. Кластер Kubernetes формируется с помощью инструмента kubeadm.

## CI/CD

Во время развертывания инфраструктуры развертывается и Jenkins, который с помощью werf собирает и публикует приложение в k8s. Благодаря werf используются принцип работы GitOps - git как единый источник истины. 

В этом проекте используется конвейер CI/CD который храниться jenkins shared library. В конвейере описаном в репозитарии приложения bfmarket-app храниться только имя namespace в k8s. Jenkins сам создает джобы, пайплайны, и сам настраивается.

## Как запустить

Для этого нужен vagrant, virtualbox, ansible, сеть 192.168.10.0/24
1. Забираем описание системы
git clone https://github.com/v71n57/bfmarket-infra
2. Добавляем ip и домены из файла ansible/hosts.j2 в /etc/hosts системы, для работы по именам.
3. Выполняем vagrant up, ждем когда выкачается ubuntu/focal64 и отработает ansible провижен.
4. В каталоге ansible запускаем скрипт magic.sh
5. Когда отработает ansible из прошлого пункта, будет доступен jenkins по ip 192.168.10.10 и порту 8080. Пароль/логин admin. Запускаем джобу с именем iSeedJob.
6. Когда отработает пайплайн из iSeedJob нужно выполнить джобу bfmarket-app.
7. Приложение будет доступно на всех нодах кластера на порту 80 и доменом example.com. Для dev бранча на dev.example.com.

**Ссылки на репозитарии:**

- [Infra](https://github.com/v71n57/bfmarket-infra) vagrant, роли и модули для ansible
- [App](https://github.com/v71n57/bfmarket-app) приложение
- [Jenkins](https://github.com/v71n57/bfmarket-jenkins) джобы, пайплайны, shared library

 