# softwareag

This is repo for a test that was put on by Softwareag for a job interview

It contains Packer and Terraform scripts. 

## Packer 
Packer builds an ami for CentOS7, it does basic functionality to get nginx up and running and then shutdowns down the instance. 

```
git clone https://github.com/rifaavalon/softwareag.git
cd packer 
packer build 
``` 

## Terraform 
Terraform scripts setup a complete environment complete with alb, autoscaling, vpc, s3 buckets, etc. 

Make sure to set your credentials appropriately as this relies on the local credentials for AWS to be used with the account they are being used 
with. 

```
aws configure 
set credentials for your aws environment
``` 

### Running the Terraform 

```
cd terraform 
cd remote_state 
terraform plan 
terraform apply 

cd .. 
cd global 
terraform plan 
terraform apply
```

