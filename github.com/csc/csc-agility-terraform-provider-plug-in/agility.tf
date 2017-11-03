variable "agility_userid" {}
variable "agility_password" {}
provider "agility" {
  userid = "${var.agility_userid}"
  password = "${var.agility_password}"
}
# Create a new Linux instance on a small server
/*resource "agility_compute" "serv" {
    name = "serv"
    active = "true"
    version = "1"
    type = "XS"
    blueprint = "DevBlueprint"
    environment = "Dev"
    project = "LoadProductName"
}*/
#Upload a License
resource "agility_license" "raghib"{

}
