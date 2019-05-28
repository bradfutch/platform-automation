#!/bin/bash

set -e

terraform_dir="/Users/bradfutch/work/pivotal/pivotal-misc/install/terraforming-aws/terraforming-pas"
state_file="$terraform_dir/terraform.tfstate"
filename=director-config-vars.yml

az0=$(terraform output --state=$state_file -json | jq -r .infrastructure_subnet_availability_zones.value[0] | xargs -I_ echo "az0: _")
az1=$(terraform output --state=$state_file -json | jq -r .infrastructure_subnet_availability_zones.value[1] | xargs -I_ echo "az1: _")

ert_subnet_0=$(terraform output --state=$state_file -json | jq -r .pas_subnet_ids.value[0] | xargs -I_ echo "ert-subnet-0: _")
ert_subnet_1=$(terraform output --state=$state_file -json | jq -r .pas_subnet_ids.value[1] | xargs -I_ echo "ert-subnet-1: _")

infra_subnet_0=$(terraform output --state=$state_file -json | jq -r .infrastructure_subnet_ids.value[0] | xargs -I_ echo "infra-subnet-0: _")
infra_subnet_1=$(terraform output --state=$state_file -json | jq -r .infrastructure_subnet_ids.value[1] | xargs -I_ echo "infra-subnet-1: _")

public_subnet_0=$(terraform output --state=$state_file -json | jq -r .public_subnet_ids.value[0] | xargs -I_ echo "public-subnet-0: _")
public_subnet_1=$(terraform output --state=$state_file -json | jq -r .public_subnet_ids.value[1] | xargs -I_ echo "public-subnet-1: _")

services_subnet_0=$(terraform output --state=$state_file -json | jq -r .services_subnet_ids.value[0] | xargs -I_ echo "services-subnet-0: _")
services_subnet_1=$(terraform output --state=$state_file -json | jq -r .services_subnet_ids.value[1] | xargs -I_ echo "services-subnet-1: _")

rds_subnet_0=$(terraform output --state=$state_file -json | jq -r .rds_subnet_ids.value[0] | xargs -I_ echo "rds-subnet-0: _")
rds_subnet_1=$(terraform output --state=$state_file -json | jq -r .rds_subnet_ids.value[1] | xargs -I_ echo "rds-subnet-1: _")

keypair_name=$(terraform output --state=$state_file -json | jq -r .ops_manager_ssh_public_key_name.value | xargs -I_ echo "keypair-name: _")
region=$(terraform output --state=$state_file -json | jq -r .region.value | xargs -I_ echo "region: _")
sec_group=$(terraform output --state=$state_file -json | jq -r .vms_security_group_id.value | xargs -I_ echo "security-group: _")
ssh_key=$(terraform output --state=$state_file -json | jq -r .ops_manager_ssh_private_key.value | xargs -I_ echo "_" | sed 's/^/  /')

echo $az0 >> $filename
echo $az1 >> $filename
echo $ert_subnet_0 >> $filename
echo $ert_subnet_1 >> $filename
echo $infra_subnet_0 >> $filename
echo $infra_subnet_1 >> $filename
echo $public_subnet_0 >> $filename
echo $public_subnet_1 >> $filename
echo $services_subnet_0 >> $filename
echo $services_subnet_1 >> $filename
echo $rds_subnet_0 >> $filename
echo $rds_subnet_1 >> $filename
echo $keypair_name >> $filename
echo $region >> $filename
echo $sec_group >> $filename
echo "ssh_key :  |" >> $filename
echo "$ssh_key" >> $filename
echo >> $filename
