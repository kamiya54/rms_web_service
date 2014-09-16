# RmsWebService

RMS Webservice APIのRubyラッパーです。

[![Gem Version](https://badge.fury.io/rb/rms_web_service.svg)](http://badge.fury.io/rb/rms_web_service)
[![Build Status](https://travis-ci.org/kamiya54/rms_web_service.svg)](https://travis-ci.org/kamiya54/rms_web_service)

#### ご注意

* 楽天市場出品者用APIです。
* 現在一部機能のみサポートしています。
* 公式のものではありません。個人が作っているものですので、ご利用は自己責任でお願いします。

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rms_web_service'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rms_web_service

## Usage

現在、itemAPIのみサポートしています。パラメータについては公式ドキュメントを参照してください。

サービスIDとライセンスキーを設定したクライアントインスタンスを生成します。各キーはRMSより発行できます。

```ruby
client = RmsWebService::Client::Item.new(service_secret: "dummy_service_secret", license_key: "dummy_license_key")
```

### RmsWebService::Client::Item

RmsWebService::Client::ItemのインスタンスがAPIの各メソッドを持っています。各メソッドへのパラメータの渡し方は下記の通りです。

```ruby
item = client.get("ed-60c-w")
# '.item_name'、'.item_price'等のメソッドを持ちます。属性については公式ドキュメントを見てください。

item = client.delete("test001")
# '.success?'で成功したかどうかを判別できます。'.errors'でエラー内容を確認できます。

item = client.update({:item_url => "ed-60c-w", :item_price => 43800})
# '.success?'で成功したかどうかを判別できます。'.errors'でエラー内容を確認できます。

item = client.insert({
  :item_url => "test001",
  :item_name => "test001",
  :item_price => "100000",
  :genre_id => "211889",
})
# '.success?'で成功したかどうかを判別できます。'.errors'でエラー内容を確認できます。

items = client.search(:item_name => "空気清浄機")
# item.getと同じ性質のインスタンスを要素として持つ配列を返します

items = client.items_update([
  {:item_url => "ed-60c-w", :item_price => 43800},
  {:item_url => "noexist", :item_price => 10800}
])
# item.updateと同じ性質のインスタンスを要素として持つ配列を返します
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rms_web_service/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
