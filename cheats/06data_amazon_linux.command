#!/bin/bash

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.common.sh"

git checkout --patch 05outputs -- terraform.tfvars