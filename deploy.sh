#!/bin/bash
docker build -t peco8/sample-node .
docker push peco8/sample-node

ssh deploy@159.203.176.175 << EOF
docker pull peco8/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi peco8/sample-node:current || true
docker tag peco8/sample-node:latest peco8/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 peco8/sample-node:current
EOF
