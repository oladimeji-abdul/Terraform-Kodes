resource "random_string" "server_suffix" {
    length = 6
    upper = false
    special = false
  
}
resource "aws_instance" "db" {
    ami = var.ami
    instance_type = var.instance_type["production"]
    key_name = aws_key_pair.ec2.key_name
    tags = {
        
        Name = "web-${random_string.server_suffix.id}"
        }
}

resource "aws_instance" "prod" {
    ami = var.ami
    instance_type = var.instance_type["production"]
    depends_on = [ aws_instance.db
     ]
    count = length(var.server)
    tags = {
      Name = var.server[count.index]
    }

  
}

resource "aws_instance" "fs" {
    ami = var.ami
    instance_type = var.instance_type["production"]
    key_name = aws_key_pair.ec2.key_name
    for_each = var.fileservers
    tags = {  
        Name = each.value
        }
        
}

resource "aws_key_pair" "ec2" {
    key_name = "ec2"
    public_key = "ssh-rsawithsomevalues"
    tags = local.common_tags
}

locals {
  common_tags = {
    Department = "finance"
    Project = "webapp"
  }
}