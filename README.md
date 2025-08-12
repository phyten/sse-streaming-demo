# sse-streaming-demo
SSE（Server-Sent Events）のストリーミングデモ用リポジトリ

## 起動方法

```bash
docker compose up --build
```

ブラウザで [http://localhost:8080](http://localhost:8080) にアクセスするとSSEとチャンク配信のデモを確認できます。

Ruby 3.4.4 と Sinatra を使用しています。
