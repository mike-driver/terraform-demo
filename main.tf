# A terraform project for demonstration purposes 
provider "aws" {
    region = "eu-west-2"
    # these credentials are held in here: c:\Secrets\secret.tfvars for security reasons and need to be referenced on command line:
    # terraform apply -var-file c:/secrets/secret.tfvars
    # terraform destroy -var-file c:/secrets/secret.tfvars
    access_key = var.access-key
    secret_key = var.secret-key
}
variable access-key{}
variable secret-key{}

#=======
resource "aws_instance" "demo_linux_web_server" {
    ami = "ami-0e80a462ede03e653"
    instance_type = "t2.micro"
    tags = {
        Name = "demo_t2_micro_linux_web_server"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket" "this_b" {
    bucket = "mikes-demo-bucket427"
    tags = {
        Name        = "Mikes bucket"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket_acl" "b_acl" {
    bucket = aws_s3_bucket.this_b.id
    acl    = "private"
}

resource "aws_s3_bucket" "this_b2" {
    bucket = "mikes-demo-bucket4272"
    tags = {
        Name        = "Mikes bucket2"
        Environment = "Dev"
    }
}

resource "aws_s3_bucket_acl" "b2_acl" {
    bucket = aws_s3_bucket.this_b2.id
    acl    = "public-read"
}