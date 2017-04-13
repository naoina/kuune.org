+++
date = "2013-10-22T18:52:15+09:00"
publishdate = "2013-10-22T18:52:15+09:00"
draft = false
title = "toCamelCaseの実装 in golang"
tags = ["go", "golang"]

+++

どうやるのがベストなのかよく知らないので色々書いてみた。

```go
package main

import (
    "bytes"
    "regexp"
    "strings"
    "testing"
    "unicode"
)

func BenchmarkSplitJoin(b *testing.B) {
    b.StopTimer()
    s := "hoge_foo_bar"
    b.StartTimer()
    for i := 0; i < b.N; i++ {
        ss := strings.Split(s, "_")
        var buf bytes.Buffer
        for _, v := range ss {
            buf.WriteString(strings.Title(v))
            buf.String()
        }
    }
}

func BenchmarkReplace(b *testing.B) {
    b.StopTimer()
    s := "hoge_foo_bar"
    b.StartTimer()
    for i := 0; i < b.N; i++ {
        strings.Replace(strings.Title(strings.Replace(s, "_", " ", -1)), " ", "", -1)
    }
}

func BenchmarkRegexp(b *testing.B) {
    b.StopTimer()
    s := "hoge_foo_bar"
    r := regexp.MustCompile(`_([a-z])`)
    fn := func(m string) string {
        return strings.ToUpper(string(m[1]))
    }
    b.StartTimer()
    for i := 0; i < b.N; i++ {
        strings.Title(r.ReplaceAllStringFunc(s, fn))
    }
}

func BenchmarkForLoop(b *testing.B) {
    b.StopTimer()
    s := "hoge_foo_bar"
    b.StartTimer()
    for i := 0; i < b.N; i++ {
        buf := make([]rune, 0, len(s))
        conv := false
        for _, v := range s {
            if v == '_' {
                conv = true
                continue
            }
            if conv {
                buf = append(buf, unicode.ToUpper(v))
                conv = false
                continue
            }
            buf = append(buf, v)
        }
        buf[0] = unicode.ToUpper(buf[0])
        _ = string(buf)
    }
}
```

私の環境でのベンチ結果はこんな感じ。

```text
% go test -bench .
testing: warning: no tests to run
PASS
BenchmarkSplitJoin       1000000              1553 ns/op
BenchmarkReplace         1000000              1220 ns/op
BenchmarkRegexp  1000000              2848 ns/op
BenchmarkForLoop         5000000               396 ns/op
ok      _/home/naoina/work/test/bench   8.056s
```
