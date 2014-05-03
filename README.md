# DodontoF-Rack

DodontoF-Rackはtorgtaitai氏の作成している[DodontoF](https://github.com/torgtaitai/DodontoF)をRackApplicationとして動作するように拡張したForkedProductです。

---

現在のVersionは **1.0-RC1** です。

**WARNING**
>現VerではWebIFは動作対象外としています。
>これについては本家で提起している[Issue]:(https://github.com/torgtaitai/DodontoF/issues/7)の取り込みを待って対応する予定です。

## 動作環境

Ruby1.9以上でのみ動作します。
また、gemコマンドの実行権限及び、gemパッケージとして[Bundler](http://bundler.io/)を事前にインストールしている必要があります。

## 機能

RackApplicationとして動作するようになります。
これによりRackに対応しているサーバアプリケーションやミドルウェア、PaaSで構築可能になると **期待されます。**

それ以外には既存のどどんとふと何も変わる所はなく、独自の機能が追加されていたりパフォーマンスが上がっていたりということは一切ありません。

### 既存のどどんとふのソースには変更を加えていない

このProductには既存どどんとふのリソース一式が含まれていますが、それらには一切手を加えていません。
(明らかにそうする方が適切と思われる場合でも変更していません)

しかし、これによりProductに新規で追加したソース・ファイルを既にデプロイしているどどんとふに追加することでも(おそらく)使う事ができます。
また、今後本家のDodontoFがVerUpした際にも比較的簡単に追従できることが期待できます。

## 使い方

### 新規に設置する

本Productをサーバの任意の場所に設置した後

```bash
$ bundle install
```

で依存パッケージを全てインストールすれば同梱の`config.ru`を使ってRackApplicationとして動作可能になります。

### 既存のどどんとふに追加する

DodontoF-Rackとして必要なリソースは`src_rack/`と`config.ru`のみです。
これらを既存のどどんとふのディレクトリ以下の同じ階層に設置すれば同様に使用できます。

### Versionの異なるどどんとふで動かす場合

DodontoF-Rackは`src_rack/customized_server.rb`で設定されているversionとして動作します。

```ruby:customized_server.rb

module DodontoF

  # versionをcustomized_serverが対応している版に固定
  LATEST_VERSION = 'Ver.1.44.01'.freeze
  LATEST_DATE = '2014/04/15'.freeze
  $version = "#{LATEST_VERSION}(#{LATEST_DATE})"
```

既存のどどんとふに追加する等、異なるversionのどどんとふで使用する場合はここの設定を正しい値に編集してください。

## LICENSE

DodontoF-Rack固有のソースは全て以下のMIT-LICENSEとして提供します。

---

Copyright (c) 2014 FaviuTy

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

以下に定める条件に従い、本ソフトウェアおよび関連文書のファイル（以下「ソフトウェア」）の複製を取得するすべての人に対し、ソフトウェアを無制限に扱うことを無償で許可します。
これには、ソフトウェアの複製を使用、複写、変更、結合、掲載、頒布、サブライセンス、および/または販売する権利、およびソフトウェアを提供する相手に同じことを許可する権利も無制限に含まれます。

上記の著作権表示および本許諾表示を、ソフトウェアのすべての複製または重要な部分に記載するものとします。

ソフトウェアは「現状のまま」で、明示であるか暗黙であるかを問わず、何らの保証もなく提供されます。ここでいう保証とは、商品性、特定の目的への適合性、および権利非侵害についての保証も含みますが、それに限定されるものではありません。 作者または著作権者は、契約行為、不法行為、またはそれ以外であろうと、ソフトウェアに起因または関連し、あるいはソフトウェアの使用またはその他の扱いによって生じる一切の請求、損害、その他の義務について何らの責任も負わないものとします。

