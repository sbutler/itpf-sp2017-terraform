#!/bin/bash

. "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.common.sh"

git checkout --patch 04variables_terraform -- terraform.tfvars
