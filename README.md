# sse-streaming-demo

SinatraとNginxでSSEとチャンク配信を試すデモ。Docker Composeひとつで起動できます。

## 起動

```bash
docker compose up --build
```

ブラウザで <http://localhost:8080> を開くと、SSEやReadableStreamのデモページが表示されます。

停止するには別ターミナルで以下を実行します。

```bash
docker compose down
```
