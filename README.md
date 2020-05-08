# vagrant-playground

## 初回起動時

vbguestのバージョンをホストOSと揃える。

```sh
$ vagrant up
# パッケージのインストールと更新をするので再起動する
$ vagrant reload
$ vagrant vbguest --status
$ vagrant vbguest --do install [machine]
$ vagrant reload [machine]
```

## sshでログイン後

mitamaeでanyenvをセットアップ

```sh
$ vagrant ssh [machine]
$ cd /vagrant/mitamae/
$ ./install_anyenv.sh
```

