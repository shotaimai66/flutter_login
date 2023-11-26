# ベースイメージ
FROM amazonlinux:2

# 作業ディレクトリの設定
WORKDIR /opt/app

# 環境変数の設定
ENV RUBY_VERSION=3.2.0
ENV YARN_VERSION=1.22.4

# 必要なパッケージのインストール
RUN yum update -y && \
    yum install -y tar gzip git wget which

# Node.js と Yarn のインストール
RUN yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y && \
    yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1 && \
    npm install -g yarn@"${YARN_VERSION}"

# Ruby のインストール
RUN yum install -y yum install -y gcc gcc-c++ glibc-devel make ncurses-devel openssl-devel autoconf readline-devel zlib-devel libyaml-devel bzip2 unzip && \
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    source ~/.bashrc && \
    rbenv install ${RUBY_VERSION} && \
    rbenv global ${RUBY_VERSION}

# Serverless Framework のインストール
RUN npm install -g serverless

# AWS CLI のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# ポートのエクスポーズ（Serverlessやその他のサービス用）
EXPOSE 3000

# コンテナ起動時のコマンド
CMD ["bash"]
