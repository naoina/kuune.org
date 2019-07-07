+++
date = "2013-06-14T20:37:05+09:00"
draft = false
title = "画像ファイルのアップロード機能が付きました"

+++

GitHubのissuesのアレです。
アップロードできるファイルタイプは `jpeg` `png` `gif` で、ファイルサイズの上限は5MBにしています。

{{< img src="2866af1b-5773-50df-91e9-ab9ffe0e2702.png" alt="a1.png" >}}

画像がアップロードされると自動的に現在のカーソル位置に画像を参照するディレクティブが挿入されます。

{{< img src="f8e6ed4b-d7dd-576f-b5fb-cc6a207b9b24.png" alt="a2.png" >}}

ディレクティブは現在選択しているマークアップ言語によって変わります。reSTを選択していればreSTの、Markdownを選択していればMarkdownの記法になります。
