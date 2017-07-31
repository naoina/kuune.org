+++
date = "2015-03-01T14:26:31+09:00"
draft = false
title = "VAIO Z (VJZ13A1) が届きました"
"text/tags" = ["linux", "vaio"]

+++

![VAIO Z 1](/image/vaio-z1.jpg)
![VAIO Z 2](/image/vaio-z2.jpg)
![VAIO Z 3](/image/vaio-z3.jpg)

## 所感

* キーボードの押下圧が軽いので良い
* 2 in 1 なのでタブレット形状にもなるが、タブレットとして使うには重い。
* USB や電源など全ての差し込み口が固いので片側を押さえながら入れないと筐体が動く
* 電源ボタンも固いので以下同上
* ペンでしかクリック（タップ？）できないのにペンをマウントするところが無い

## Arch Linux での現状

### 動く

* キーボード
* 内臓カメラ
* Touchpad（ただしポインタデバイスとしてのみ）
* Touchscreen（筆圧感知はテストしてない）

### 動かない

* Touchpad が Touchpad として認識されない

    * つまり二本指でのスクロールができないゴミと化す
    * Lenovo Yoga 3 でも同じっぽい

* Suspend から帰ってこない

    * 黒い画面のまんま
    * backlight が暗いだけではない

* Hibernate から帰ってきたら Xorg の画面描画がおかしい

    * drm と i915 関連でエラーが出ている

### 追記（2015-03-01T17:38:34+09:00）

* linux-drm-intel-nightly を AUR から入れて使うようにしたら Hibernate が動くようになった

    * カーネルバージョンは 4.0.0-rc1-drm_intel_nightly_20150301 になった
    * 依然 Suspend は動かない

あと何かあれば追記する。

### 追記 ( 2016-09-06T13:47:56+09:00 )

いい加減カーネル 4.2.5 のままにするのは厳しくなってきたのでちょっと気合入れて Linux カーネルのソース見て 4.7.2 でタッチパッド動くようにした。といってもやったのは識別子追加しただけ。

```diff
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index d15b338..1e84449 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1233,6 +1233,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
 	{ "ELAN1000", 0 },
+	{ "VAIO0001", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, elan_acpi_id);
```
