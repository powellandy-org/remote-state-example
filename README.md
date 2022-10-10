# remote-state-example

- Instructions

```bash
git clone git@github.com:powellandy-org/remote-state-example.git

cd remote-state-example
cd base-state/
# omit AWS_PROFILE if you are not using many AWS Keys
AWS_PROFILE=powand terraform init
AWS_PROFILE=powand terraform apply

cd ../down-stream-project/
AWS_PROFILE=powand terraform init
AWS_PROFILE=powand terraform apply
```

- remote state example is available in the /down-stream-project/main.tf around with the resource
```terraform
data "terraform_remote_state" "base" {
  backend = "s3"
  config = {
    bucket         = "aws-base-state-powand"
    key            = "terraform.tfstate"
    region         = "us-east-2"
  }
}
```