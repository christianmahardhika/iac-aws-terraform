# iac-aws-terraform

## Don't Forget

Setup AWS cli Configuration access keys and secret keys

    ```bash
    aws configure
    ```

## TODO:

Separate into 2 files:

- main.tf
- variables.tfvars

make modular tf files

## Before you start

- Create a aws_keys_pairs.pem file inside the folder eg. `iac-aws-terraform/ec2/microk8s/aws_keys_pairs.pem`


## List Commands

Init Terraform

```bash
terraform init
```

Plan Terraform

```bash
terraform plan
```

Apply Terraform

```bash
terraform apply
```

Destroy Terraform

```bash
terraform destroy
```
