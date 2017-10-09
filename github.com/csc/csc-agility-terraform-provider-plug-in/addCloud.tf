variable "agility_userid" {}
variable "agility_password" {}
provider "agility" {
  userid = "${var.agility_userid}"
  password = "${var.agility_password}"
}
resource "agility_addcloudprovider" "AWS" {
  cloudname = "PM-AWS"
  description = "Cloud provider created from terraform"
  cloudtype = "Amazon EC2 Cloud"
  hostname = "ec2.eu-west-1.amazonaws.com"
  publickey = "AKIAJI4INTOM6BXDWR3A"
  privatekey = "WfUf+j2fPB9VGg1qsWJxSMS0FUxnQrW+tSurofSC"
  awsaccountnumber = "531227887946"
}
resource "agility_synccloudprovider" "SyncAWS"{
  cloudname ="PM-AWS"
  depends_on = ["agility_addcloudprovider.AWS"]
}