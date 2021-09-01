# コードを実行するコンテナイメージ
FROM alpine:3.10

# アクションのリポジトリからコードファイルをコンテナのファイルシステムパス `/`にコピー
COPY entrypoint.sh /entrypoint.sh
# タイムゾーン設定
ENV TZ Asia/Tokyo

# 依存パッケージのインストール
RUN yum install -y gcc git

# libfaketimeのインストール
WORKDIR /
RUN git clone https://github.com/wolfcw/libfaketime.git
WORKDIR /libfaketime/src
RUN make install \
 && echo -e '/usr/local/lib/faketime/libfaketime.so.1' > /etc/ld.so.preload

# 環境変数の設定
# Java プログラムを実行する場合は DONT_FAKE_MONOTONIC が必要です。
# システム日付の変更は1秒間隔でチェックします。
ENV DONT_FAKE_MONOTONIC=1
ENV FAKETIME_CACHE_DURATION=1

# 作業ディレクトリの変更
WORKDIR /

# システム日付の変更
# /etc/faketimerc または環境変数 FAKETIME にフォーマットを指定します。
# フォーマットは「相対日時」や「指定日時」などが指定できます。
# 詳しくは以下のURLを参照してください。
# https://github.com/wolfcw/libfaketime

# テストコマンド実行
CMD date \
 && echo -e '@2000-01-01 09:00:00' > /etc/faketimerc \
 && date \
 && echo -e '+3d' > /etc/faketimerc \
 && date \
 && echo -e '-10y' > /etc/faketimerc \
 && date \
 && rm -f /etc/faketimerc \
 && date