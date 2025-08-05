#!/bin/bash

#Login to AWS ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 496637883626.dkr.ecr.us-east-1.amazonaws.com
docker pull 496637883626.dkr.ecr.us-east-1.amazonaws.com/mayur_ecr5:v3
docker stop my-container || true
docker rm my-container || true
docker run -d -p 80:5000 -e DAGSHUB_PAT=989502cf022c36fe2d32f50b32bec4d244795e64 --name mayur-app 496637883626.dkr.ecr.us-east-1.amazonaws.com/mayur_ecr5:v3
