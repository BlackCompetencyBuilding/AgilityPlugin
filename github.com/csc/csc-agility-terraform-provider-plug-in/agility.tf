
provider "agility" {
    userid = "${var.userid}"
    password = "${var.password}"
}

# Create a new Linux instance on a small server

resource "agility_compute" "serv" {
    name = "${var.deployement_name}"
    active = "${var.active}"
    version = "${var.version}"
    type = "${var.type}"
    blueprint = "${var.blueprint_name}"
    environment = "${var.environment_name}"
    project = "${var.project_name}"
}

