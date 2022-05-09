resource "aws_key_pair" "mini_key_pair" {
    key_name = KEY_NAME
    public_key = PubKey
    tags = {
        "Name" = ""
    }
}