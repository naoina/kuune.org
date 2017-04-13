+++
date = "2013-06-08T01:26:46+09:00"
publishdate = "2013-06-08T01:26:46+09:00"
draft = false
title = "MySQLからPostgreSQLに移行しました"

+++

plogのデータベースエンジンは開発環境ではSQLite3、プロダクションではMySQL 5.6を使用していましたが、現在DjangoのDateTimeFieldがマイクロ秒をサポートしていなかったためPostgreSQLに変更しました。
この変更に際して、データをMySQLからPostgreSQLにマイグレーションする必要がありましたので、ググって出てきた下記ブログを参考にマイグレーションを行いました。

http://zerokspot.com/weblog/2008/07/26/move-a-django-site-to-postgresql-check/

古い記事ですが、このまんまでエラーも出ず幸い苦も無くマイグレーションができ、現在はPostgreSQLで稼働しています。
