+++
date = "2017-05-06T00:20:21+09:00"
draft = false
logo = ""
logosmall = ""
"text/tags" = ["deeplearning", "keras", "tips"]
title = "Keras モデルを圧縮して保存する"

+++

[Keras](https://keras.io/) でモデルを保存するには `model.save` か `keras.models.save_model` を使い、ファイル形式は `HDF5` で保存されます。これは自分のように [keras.callbacks.ModelCheckpoint](https://keras.io/callbacks/#modelcheckpoint) で 1 epoch 毎にモデルを保存していると結構ディスク容量を食います。そこで、容量を抑えるためにモデルを圧縮して保存できるようにします。

`keras.models.save_model` は [h5py.File](http://docs.h5py.org/en/latest/high/file.html#File) を呼んでいます。`h5py.File` はファイルオブジェクトを取れないので一旦テンポラリファイルに書き出してからそれを圧縮します。

```python
import os
import lzma
import tempfile
import shutil
from functools import partial
from keras import models


def save_model(model, path):
    directory = os.path.dirname(path)
    with tempfile.NamedTemporaryFile(dir=directory) as f, lzma.open(path, 'wb') as wf:
        models.save_model(model, f.name)
        f.seek(0)
        shutil.copyfileobj(f, wf)

model.save = partial(save_model, model)
model.save('model.h5.xz')
```

圧縮されたファイルのままでは `keras.models.load_model` で読めないので、読み込み側も作ります。

```python
def load_model(path, custom_objects=None):
    with lzma.open(path, 'rb') as f, tempfile.NamedTemporaryFile(dir=directory) as wf:
        shutil.copyfileobj(f, wf)
        wf.seek(0)
        return models.load_model(wf.name, custom_objects=custom_objects)
```

手元にあったモデルでどのぐらい縮んだか見てみます。

```
-rw-r--r-- 1 naoina users 17679144 May  5 22:57 updown-both-01483-m5.h5
-rw-r--r-- 1 naoina users 13140532 May  5 22:58 updown-both-01483-m5.h5.xz
-rw-r--r-- 1 naoina users 29194056 May  5 22:58 updown-both-01812-m5.h5
-rw-r--r-- 1 naoina users 23654004 May  5 22:58 updown-both-01812-m5.h5.xz
```

約 4 MB ですね。思ったより縮みませんでした。1000 epochs 回して 4GB 程度の節約でしょうか。

ちなみに学習データとして使っている pickle 化した為替データだと約 16% ぐらいに縮みました。

```
-rw-r--r-- 1 naoina users 134088149 May  5 23:01 train_EURUSD_m1.pkl
-rw-r--r-- 1 naoina users  21536728 May  5 23:01 train_EURUSD_m1.pkl.xz
```
