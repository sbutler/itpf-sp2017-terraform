#!/bin/bash

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.common.sh"

git checkout --patch 06data_amazon_linux -- terraform.tfvars
