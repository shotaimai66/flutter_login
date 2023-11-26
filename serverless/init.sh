#!/bin/bash
rm -rf .serverless

yarn init -y && yarn install

sls plugin install -n serverless-ruby-layer
sls plugin install -n serverless-offline
sls plugin install -n serverless-prune-plugin
sls plugin install -n serverless-localstack

bundle install
