#chmod 400 mini-devops.pem
#ssh-keygen -y -f mini-devops.pem >> terraform_ec2_key.pub

resource "aws_key_pair" "mini_key_pair" {
    key_name = mini-devops
    public_key = "file(terraform_ec2_key.pub)"
    tags = {
        "Name" = "mini-key-pair"
    }
}
