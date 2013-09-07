imadesyo(今でしょ!).vim
========

## これは何？
いつ反映(実行)するか？  
今でしょ!  
編集中のファイルを即座に実行したり反映することが出来るプラグインです 多分

/etc/apacheを編集中に実行  => apacheの再起動  
/etc/postfixを編集中に実行 => postfixの再起動  
シェル編集中に実行         => shebangに書かれたプログラムで実行  
perl編集中に実行           => perlで実行  
みたいな感じに編集中のファイルに合わせて反映(実行)をしてくれます

## インストール
vundleとかの人はこんな感じ

    Bundle 'yaasita/imadesyo'
    :BundleInstall

そのままインストールする場合はこんな感じ

    $ cd
    $ mkdir .vim
    $ wget -O - https://github.com/yaasita/imadesyo/archive/master.tar.gz | tar xzv
    $ mv imadesyo-master/* .vim
    :helptags ~/.vim/doc

## 使い方
ファイルを編集中に以下のコマンドで実行・反映されます

    :Imadesyo

下記のようにマッピングすればもっと早く実行できます
下記例はノーマルモード`,e`で実行(`.vimrc`に書いてください)

    nnoremap ,e :Imadesyo<CR>

たとえば `/etc/postfix/main.cf` を編集中に`,e`を入力すると
以下のコマンドを実行したことになります

    postfix check && service postfix restart

`#!/usr/bin/env ruby`で始まるスクリプトを編集中に`,e`を入力すると
以下のコマンドを実行したことになります

    /usr/bin/env ruby 編集中のファイル


## ヘルプ

    :h imadesyo@ja

## 対応ファイル
(多分)対応しているもの
* vimスクリプト
* .mailfilter
* grub
* aliases
* apache2
* sources.list
* bind9
* isc-dhcp-server
* fstab
* lighttpd
* logrotate
* munin
* mysql
* nagios-nrpe-server
* nagios3
* nginx
* ntp
* postfix
* rsyslog
* samba
* smartd
* squid3
* ssh
* unbound
* varnish
* vsftpd
* rspec
* shebangが書かれているスクリプトファイル
* vimのfiletype = 実行コマンドのもの(perl,ruby,expect等)

それぞれ実行すると何がおきるかはスクリプト参照

## お願い 
不備があったら直して頂けるとうれしいです
ｍ（ _ _ ）ｍ

