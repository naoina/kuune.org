+++
date = "2016-05-12T20:48:55+09:00"
draft = false
"text/tags" = ["aws", "s3", "cloudfront"]
title = "Amazon S3 + CloudFront で始める静的サイトホスティング"
+++

## はじめに

静的サイトとはサーバー側で動的にページを生成しないウェブサイトのことです。静的サイトはその特徴から、ウェブアプリケーションフレームワークを使わずに Nginx や Apache などの HTTP サーバーから直接配信してリソースを削減しつつパフォーマンスを上げることが可能です。それには自前でサーバーを用意して管理する必要がありますが、できればサーバーの管理をせずに静的サイトの恩恵を受けたいところです。そこで Amazon S3 の Static Website Hosting と Amazon CloudFront を使って、自前でサーバーを管理することなく静的サイトの配信を行います。

## Amazon S3 の設定

まず Amazon S3 のバケットを作成します。今回のバケット名は静的サイトのドメインと同じにして、リージョンは 1 番安い US Standard を選びます。CloudFront は世界各国のエッジサーバーから配信するため物理的に近いリージョンを選ぶ必要がないためです。

{{< img src="1d7af2f.png" alt="1d7af2f" >}}

作成したバケットで `静的ウェブサイトホスティング` を有効にします。これが有効になっていない場合、S3 は `https://example.com/hoge/` のようなアクセスで `/hoge/index.html` を返してくれず 403 Forbidden を返してしまいます。

{{< img src="1bc170a.png" alt="1bc170a" >}}

CloudFront からアクセスできるようにバケットポリシーを設定します。

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::kuune.org/*"
      ],
      "Condition": {
        "StringEquals": {
          "aws:UserAgent": "Amazon CloudFront"
        }
      }
    }
  ]
}
```

静的サイトは CloudFront を通してのみ見えるようにしたいので、CloudFront の UserAgent からのアクセスのみに制限しています。もっとも、UserAgent は簡単に偽装できるので本質的な制限ではありませんが、無いよりマシ程度に考えます。静的ウェブサイトホスティングでのアクセス制限方法で、もっと良い方法があれば教えてください。

### IAM の設定

S3 へのアップロードに必要な IAM を設定します。TravisCI や CircleCI などから自動で S3 にアップロードする場合や、[AWS CLI](https://aws.amazon.com/jp/cli/) を使って S3 にアップロードする場合に必要です。適当な IAM ユーザーを作成したあと、Amazon S3 へのアップロードができるようにポリシーを IAM ユーザーに設定します。必要な権限は

- `GetBucketLocation`
- `ListBucket`
- `PutObject`

の 3 つです。もし AWS CLI の sync を使う場合は `DeleteObject` も必要になります。下記は実際に IAM ユーザーへ設定しているポリシーの例です。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1462794682000",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketLocation",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::kuune.org"
            ]
        },
        {
            "Sid": "Stmt1462794768000",
            "Effect": "Allow",
            "Action": [
                "s3:DeleteObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::kuune.org/*"
            ]
        }
    ]
}
```

### 静的サイトのアップロード

静的サイトのコンテンツを S3 にアップロードしましょう。アップロード先は作成した S3 バケットのルートです。アップロードする静的サイトを作成するにはいくつか方法がありますが、Static Site Generator という markdown などから静的サイトを生成してくれるエンジンがあるのでそれを使うと簡単に作成できます。

## CloudFront の設定

CloudFront のディストリビューションを作成します。今回は静的サイトの配信が目的なので配信方法は `Web` を選択します。

{{< img src="c09e457.png" alt="c09e457" >}}

Origin Settings は下図のように設定します。

{{< img src="115e142.png" alt="115e142" >}}

`Origin Domain Name` には先程作成した S3 のバケットの静的ウェブサイトホスティングのエンドポイントを指定します。サジェストされる S3 Origin は **選択しません**。これで S3 をオリジンサーバーとして CloudFront がファイルを取得してくれます。S3 の静的ウェブサイトホスティングは HTTP でしかアクセスできないので `Origin Protocol Policy` は `HTTP Only` を選択します。

次に Default Cache Behavior Settings を設定します。

{{< img src="fb99297.png" alt="fb99297" >}}

常に HTTPS アクセスになるように `Viewer Protocol Policy` は `Redirect HTTP to HTTPS` を選択します。世の中は今常時 SSL 化の流れにあるので、特に理由がなければ HTTPS にするのがベターです。CloudFront にコンテンツを gzip 圧縮して配信してもらうよう `Compress Objects Automatically` は Yes にします。転送量が減るので多少なりとも転送料金の節約になります。

次に Distribution Settings の設定です。

{{< img src="0c6426e.png" alt="0c6426e" >}}
{{< img src="023ba92.png" alt="023ba92" >}}

このブログのように日本向けであれば `Price Class` は `Use Only US, Europe and Asia` で十分です。`Alternate Domain Names (CNAMEs)` には静的サイトのドメインを入力します。SSL を有効にするため `SSL Certificate` は `Custom SSL Certificate` を選択します。SSL 証明書を持っていない場合は `Request an ACM certificate` から AWS Certificate Management (以下 ACM) を使って無料で取得できます。今回は新規に取得しますが、既に証明書持っている場合は [こちら](http://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/id_credentials_server-certs_manage.html) を参照してください。

### 証明書の取得

CloudFront に設定する SSL 証明書を取得します。ACM を使えば無料で取得できるのでこれを利用します。

{{< img src="5d142d9.png" alt="5d142d9" >}}

証明書をリクエストすると下図のようなメールアドレスに確認メールが送信されます。仮に下記のようなメールアドレスを持っていない場合は Whois の管理者メールアドレスを自身のアドレスにしてメールを受け取れるようにする必要があります。ドメイン管理サービスの Whois 代理公開を設定していた場合は一時的に自身の情報に Whois 情報を更新してから証明書をリクエストしましょう。

{{< img src="a90ad5a.png" alt="a90ad5a" >}}

証明書が取得できたら Distribution Settings に戻って証明書を CloudFrond に設定します。下図のリロードボタンを押下してから先ほど取得した証明書を選択します。

{{< img src="eb88978.png" alt="eb88978" >}}

これで CloudFront のディストリビューションを作成する準備ができました。下部にある `Create Distribution` を押下して作成しましょう。CloudFrond が Deployed になるには少々時間がかかるので気長に待ちます。

## DNS の設定

最後に DNS を設定します。CloudFrond のディストリビューションを作成したら `.cloudfront.net` で終わるドメインが割り当てられます。このドメインを DNS の CNAME レコードに指定すれば独自ドメインでも CloudFront で配信されるコンテンツにアクセスできるようになります。もし Zone apex で運用する場合は Route 53 を使ってエイリアスとして割り当てます。

{{< img src="fbcdfcc.png" alt="fbcdfcc" >}}

## 注意点

CloudFrond は転送量での課金なので、その月にどれぐらいの請求がくるのかわかりません。会社であればあまり問題になりませんが、個人サイトなどで急激にアクセスが増えたりするととんでもない額の請求になる可能性があります。ですので、[こちら](https://docs.aws.amazon.com/ja_jp/awsaccountbilling/latest/aboutv2/monitor-charges.html) を参考に Billing Alerm は設定しておくことをおすすめします。

## まとめ

Amazon S3 と CloudFront を使って自前でサーバーを持つことなく静的サイトをホスティングする方法を紹介しました。最近は Static Website Generator がたくさんあり、静的サイトを作成するのも手軽になっていますので、AWS を使ってサーバー管理をすることなく自サイトを構築してみてはいかがでしょうか。
