variable "access_key" { #Todo: uncomment the default value and add your access key.
        description = "Access key to AWS console"
        default = "AKIA4WLPGLQQHT44RSHF"
}

variable "secret_key" {  #Todo: uncomment the default value and add your secert key.
        description = "Secret key to AWS console"
        default = "QIXBNg3p71HZIqAcYNDaHTHt6z+QUhVuMHYkcMwt"
}

variable "ami_key_pair_name" { #Todo: uncomment the default value and add your pem key pair name. Hint: don't write '.pem' exction just the key name
        default = "samailawsclassroom"
}


variable "region" {
        description = "The region zone on AWS"
        default = "ap-south-1" #The zone I selected is us-east-1, if you change it make sure to check if ami_id below is correct.
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-08bf489a05e916bbd"   #"ami-0dee22c13ea7a9a67" #Ubuntu 24.04
}

variable "instance_type" {
        default = "t2.micro" #the best type to start k8s with it,

}
variable "number_of_instance" {
        description = "number of instances"
        default = 1
}

variable "name" {
        description = "number of instances"
        default = "samail"
}
