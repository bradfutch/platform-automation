# Platform Automation

This is a fork of the pivotal Platform Automation repo.  This will automate the spin up of a Pivotal Cloud Foundry foundation including the necessary IaaS paving for AWS.  

# Instructions

You'll need to create a service account with sufficient permissions.  I don't list those, but you can find them in the PCF documentation.  You will also need to create 3 variables files that contain information needed to do the automation.  

## terraform-vars

```
---
env_name: "sandbox"
hosted_zone: "yourdomain.com"
access_key: "<your_access_key_id>"
secret_key: "<your_secret_key>"
region: "us-west-2"
availability_zones: ["us-west-2a", "us-west-2c"]
ops_manager_ami: "<current_opsman_ami_for_this_region"
rds_instance_count: 1
dns_suffix: "yourdomain.com"
vpc_cidr: "10.0.0.0/16"
use_route53: true
use_ssh_routes: true
use_tcp_routes: false
terraform_bucket: <your_bucket>
automation_bucket: <your_other_bucket>
terraform_git: https://github.com/bradfutch/terraforming-aws.git
automation_git: https://github.com/bradfutch/platform-automation.git
```

## auth

```
---
username: admin
password: <opsman_password>
decryption-passphrase: <opsman_decryption_passphrase>
```

## env

```
---
target: <to-be-replaced>
connect-timeout: 30            # default 5
request-timeout: 1800          # default 1800
skip-ssl-validation: true     # default false
```

## Create Pipeline

Now that you've created your variables you need to configure this pipeline to run on a concourse host.  I don't cover that here, you bring your own or use something like `wings.pivotal.io`.

fly -t wings set-pipeline -p terraform-aws -c pipelines/terraform-pipeline.yml -l vars/terraform-vars.yml -l vars/auth.yml -l vars/env.yml
