![alt text]("https://circleci.com/gh/:owner/:repo.png?circle-token=:circle-token" "")
# Martian Co
Making planets more betters. 

## Usage
This is a demo repo for training purposes. The prefered method of using this repo is to fork it so that you can edit and modify as you see fit. 

## Setup
In order for this repo to function, you must export your AWS account credentials as environment variables:
```
export AWS_ACCESS_KEY_ID={your AWS Key here}
export AWS_SECRET_ACCESS_KEY={your AWS Secret here}
export AWS_SESSION_TOKEN={your AWS Session Token here}
```
You will need to modify the AWS Region and the allowed AWS account in the variables.tf file:
```
variable "aws_region" {
  default = ""
}

variable "account_ids" {
  default = ""
}
```

