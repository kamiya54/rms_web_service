# RmsWebService

RMS Webservice APIのRubyラッパーです。

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

`RmsWebService.configuration`でサービスIDとライセンスキーを設定できます。各キーはRMSより発行できます。

```ruby
RmsWebService.configuration do |c|
  c.service_secret = "dummy_service_secret"
  c.license_key = "dummy_license_key"
end
```

### RmsWebService::Item

RmsWebService::ItemがAPIの各メソッドを持っています。パラメータを渡す場合はハッシュ、複数のItemを渡す場合は配列を使用します。

各メソッドが返すインスタンスがどのようなメソッドを持つかは公式ドキュメントを見るのが早いと思います。更新に失敗した場合のみ、`errorMessages`に設定されているエラー関係のメソッドをサポートします。

```ruby
# item.get
item = RmsWebService::Item.get(:item_url => "ed-60c-w")
p item.item_name # => "ed-60c-w"

# item.update
item = RmsWebService::Item.update({:item_url => "ed-60c-w", :item_price => 43800})
p item.system_status # => "OK"

# item.insert
item = RmsWebService::Item.insert({
  :item_url => "test001",
  :item_name => "test001",
  :item_price => "100000",
  :genre_id => "211889",
})
p item.system_status # => "OK"

# item.delete
item = RmsWebService::Item.delete(:item_url => "test001")
p item.system_status # => "OK"

# item.search
items = RmsWebService::Item.search(:item_name => "空気清浄機")
items.each do |item|
  p item.item_name
end

# items.update
items = RmsWebService::Item.items_update([
  {:item_url => "ed-60c-w", :item_price => 43800},
  {:item_url => "noexist", :item_price => 10800}
])
items.each do |item|
  if item.code == 'N000'
    p item.item_url # => "ed-60c-w" 
  else
    p item.error_id # => "335"
    p item.msg # => "商品管理番号欄（商品URL）で指定された商品が見つかりません。更新・変更、削除の場合は、存在する商品の商品管理番号（商品URL）をご指定ください。"
  end
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rms_web_service/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
