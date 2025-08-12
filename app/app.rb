# frozen_string_literal: true
require "sinatra"
require "sinatra/streaming"
require "json"

set :server, :puma
set :bind, "0.0.0.0"
set :port, 9292

helpers Sinatra::Streaming

get "/" do
  send_file File.join(settings.public_folder, "index.html")
end

# SSE（ChatGPT風ストリーミング）
get "/sse" do
  content_type "text/event-stream"
  headers["Cache-Control"]     = "no-cache"
  headers["Connection"]        = "keep-alive"
  headers["X-Accel-Buffering"] = "no"

  prompt = params["prompt"].to_s
  tokens = (prompt.empty? ? "これはSSEのデモです。" : "「#{prompt}」への応答をストリーミング中。").chars

  stream(:keep_open) do |out|
    out << "retry: 2000\n\n"

    Thread.new do
      begin
        tokens.each_with_index do |ch, i|
          out << "event: token\n"
          out << "data: #{({ index: i, text: ch }.to_json)}\n\n"
          sleep 0.05
        end
        out << "event: done\n"
        out << "data: [DONE]\n\n"
      rescue => e
        out << "event: error\n"
        out << "data: #{({ error: e.class.name, message: e.message }.to_json)}\n\n"
      ensure
        out.close
      end
    end
  end
end

# おまけ：SSEではない素のchunk配信
get "/chunk" do
  content_type "text/plain; charset=utf-8"
  headers["Cache-Control"]     = "no-cache"
  headers["X-Accel-Buffering"] = "no"

  stream do |out|
    "これはchunked transferのデモです。\n".chars.each do |ch|
      out << ch
      sleep 0.05
    end
  end
end
