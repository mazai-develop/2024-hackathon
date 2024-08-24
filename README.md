# 2024-hackathon

### exec commands

```sh
docker compose run --rm terraform init
docker compose run --rm terraform plan
docker compose run --rm terraform apply
```

### format, testing commands

```sh
docker compose run --rm terraform fmt
docker compose run --rm terraform validate
```

### appendix

```sh
docker compose run --rm terraform apply --auto-approve
```


## EC2マシンでのHealth Check Serverを立てる

### Health Check Serverのインストール

```sh
ssh
apt update && sudo apt install -y nodejs npm
mkdir health_server && cd health_server
npm install -g http-server
nano data.json
./node_modules/http-server/bin/http-server -p 8080
```

※ブラウザから`http://<EC2マシンのIPアドレス>:8080/data.json`にアクセスして、`data.json`の内容が表示されればOK

## k3supのインストール

```sh
curl -sLS https://get.k3sup.dev | sh
sudo install k3sup /usr/local/bin/
k3sup --help
```

## k3sのインストール

```sh
k3sup install --local --user=$USER --local-path ./kubeconfig
```

## k3sのアンインストール

```sh
k3sup uninstall
```