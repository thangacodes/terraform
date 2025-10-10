variable "region" {
  description = "Region, where you are deploying the application"
}

variable "image_id" {
  description = "VM Image id specification"
}

variable "vm_spce" {
  description = "EC2 instance type"
}

variable "sgp" {
  description = "Security Group that will be associated to the EC2 instance"
}

variable "keyname" {
  description = "Connect EC2 machine via public key"
}