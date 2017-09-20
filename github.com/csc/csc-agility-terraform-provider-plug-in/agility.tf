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
    licenseversion = "3.0"
    licensee = "qa_unlimited_allmod_alladapters"
    adapters = "Amazon EC2 Cloud"
    adapters = "VMware vSphere Cloud"
    adapters = "vCloud Director"
    adapters = "Terremark VCloud Express"
    adapters = "Savvis"
    adapters = "Fujitsu"
    adapters = "KMIP"
    adapters = "hyperV"
    adapters = "OpenStack"
    adapters = "Azure"
    modules = "Store"
    modules = "Designer"
    modules = "Operations"
    modules = "Planner"
    modules = "Release Manager"
    modules = "Admin"
    modules = "Launch Pad"
    modules = "Policy"
    modules = "Reporting"
    modules = "API"
    issueday = "11"
    issuemonth = "12"
    issueyear = "2012"
    expiryday = "-1"
    expirymonth = "-1"
    expiryyear = "-1"
    numberofclients = "-1"
    maxpermittedinstances = "-1"
    mask = "0.0.0.0"
    ipaddr = "127.0.0.1"
    dbquerytype = "DEFAULT"
    signature = "ew3IKfLOV0XOxjsD+YfVonZMAeI="
}
