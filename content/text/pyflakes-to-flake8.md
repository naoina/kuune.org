+++
date = "2013-05-09T23:37:20+09:00"
draft = false
title = "pyflakes から flake8 に乗り換えて幸せになった話"
tags = ["python", "flake8"]

+++

Python のコードチェッカーはいくつかありますが、私は設定無しで実用になる [pyflakes](https://pypi.python.org/pypi/pyflakes) を使っていました。
しかし、最近 Django を使っていて settings.py を production や development に分ける際に

```python
from plog.settings.base import *

# some settings...
```

のように書いているのですが、これだと pyflakes では

```
'from plog.settings.base import *' used; unable to detect undefined names
```

と言われてしまいます。これを出ないようにしようとしても、 pyflakes にはエラーや警告を制御するような機能がありません。
そこで pyflakes の代替として [flake8](https://pypi.python.org/pypi/flake8) を使うことにしました。
flake8 は pyflakes と [pep8](https://pypi.python.org/pypi/pep8) のラッパーですが、いくつか機能が追加されたものです。
flake8 では前述の pyflakes の警告を以下のようにして抑制することができます。

```python
from plog.settings.base import *  # noqa

# some settings...
```

エラーや警告を抑制したい行の末尾に特殊なコメント `# noqa` を追加するだけです。
また、 flake8 は設定ファイルで常に特定のエラーや警告を制御することもでき、大変幸せになれます。

さらに幸せを享受したい場合は http://flake8.readthedocs.org/en/latest/ の公式ドキュメントを読んでください。
