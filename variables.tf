variable "prefix" {
    type = string
    description = "Naming prefix for resources"
    default = "tacos"
  
}

resource "random_integer" "suffix" {
    min = 10000
    max = 99999
  
}

locals {
  ado_project_name          = "${var.prefix}-project-${random_integer.suffix.result}"
  ado_project_desc          = "project for ${var.prefix}"
  ado_project_visibility    = "${var.prefix}-pipeline-1"
}

variable "server" {
  default = ["web1", "web2", "web3"]
  type = list(string)
  
}

variable "instance_type" {
  type = map(string)
  default = {
    production = "m5.large"
    dev        = "t2.micro"
  }
  
}

variable "ami" {
  default = "somevalues"
  type = string
  
}

variable "fileservers" {
  type = set(string)
  default = [ "fs1", "fs2" ]
  
}

variable "mailserver" {
  type = object({
    name     = string
    ipadress = string
    port     = number
  })

  default = {
    name = "orgnameserver"
    ipadress = "192.168.20.5"
    port = 25

  }
  
}

variable "web" {
  type = tuple([ string, number, bool ])

  default = [ "name", 0, false ]
  
}

output "public_ip" {
  value = aws_instance.prod.public_ip
  description = "Print the public ip of the instance"
  sensitive = true
  depends_on = [ aws_instance.prod ]


}

variable "amii" {
  type = map(string)
  default = {
              us-east-1 = "ami-abc"
              us-east-2 = "ami-def"
              us-east-3 = "ami-ghi"
  }  
}