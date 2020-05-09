# vagrant-playground

## 初回起動時

vbguestのバージョンをホストOSと揃える。

```sh
$ vagrant up
# パッケージのインストールと更新をするので再起動する
$ vagrant reload
$ vagrant vbguest --status
$ vagrant vbguest --do install -b -R [machine]
```

