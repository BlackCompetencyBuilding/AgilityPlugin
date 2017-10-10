/*variable "agility_userid" {}
variable "agility_password" {}
provider "agility" {
    userid = "${var.agility_userid}"
    password = "${var.agility_password}"
}
# Create a new Linux instance on a small server
resource "agility_compute" "myserver" {
    name = "myserver"
    active = "true"
    version = "1"
    type = "t1.micro"
    blueprint = "SOE-RHEL-6.7"
    environment = "Development"
    project = "StackImportSOE"
}*/
resource "agility_createcontainer" "HRContainer" {
  parentcontainername = "${var.headcontainername}"
  container = "${var.parentcontainer1}"
  description = "Container created via terraform"
}
resource "agility_createcontainer" "FinanceContainer" {
  parentcontainername = "${var.headcontainername}"
  container = "${var.parentcontainer2}"
  description = "Container created via terraform"
}
resource "agility_createcontainer" "ITContainer" {
  parentcontainername = "${var.headcontainername}"
  container = "${var.parentcontainer3}"
  description = "Container created via terraform"
}
resource "agility_createcontainer" "SubHRContainer" {
  parentcontainername = "${var.parentcontainer1}"
  container = "${var.subcontainer1}"
  description = "Container created via terraform"
  depends_on = ["agility_createcontainer.HRContainer"]
}
resource "agility_createcontainer" "AdminContainer" {
  parentcontainername = "${var.parentcontainer2}"
  container = "${var.subcontainer2}"
  description = "Container created via terraform"
  depends_on = ["agility_createcontainer.ITContainer"]
}
resource "agility_createcontainer" "DeveloperContainer" {
  parentcontainername = "${var.parentcontainer2}"
  container = "${var.subcontainer3}"
  description = "Container created via terraform"
  depends_on = ["agility_createcontainer.ITContainer"]
}
resource "agility_createproject" "HRProject"{
  parentcontainername="${var.subcontainer1}"
  project="${var.project1}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.SubHRContainer"]
}
resource "agility_createproject" "FinanceProject"{
  parentcontainername="${var.parentcontainer3}"
  project="${var.project2}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.FinanceContainer"]
}
resource "agility_createproject" "WindowsProject"{
  parentcontainername="${var.subcontainer2}"
  project="${var.project3}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.AdminContainer"]
}
resource "agility_createproject" "LinuxProject"{
  parentcontainername="${var.subcontainer2}"
  project="${var.project4}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.AdminContainer"]
}
resource "agility_createproject" "DotNetProject"{
  parentcontainername="${var.subcontainer3}"
  project="${var.project5}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.DeveloperContainer"]
}
resource "agility_createproject" "JavaProject"{
  parentcontainername="${var.subcontainer3}"
  project="${var.project6}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.DeveloperContainer"]
}
resource "agility_createproject" "PythonProject"{
  parentcontainername="${var.subcontainer3}"
  project="${var.project7}"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.DeveloperContainer"]
}
resource "agility_createenvironment" "DevelopmentHR"{
  parentprojectname="${var.project1}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.HRProject"]
}
resource "agility_createenvironment" "UATHR"{
  parentprojectname="${var.project1}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment2_type}"
  depends_on = ["agility_createproject.HRProject"]
}
resource "agility_createenvironment" "ProductionHR"{
  parentprojectname="${var.project1}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.HRProject"]
}
resource "agility_createenvironment" "DevelopmentFinance"{
  parentprojectname="${var.project2}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.FinanceProject"]
}
resource "agility_createenvironment" "UATFinance"{
  parentprojectname="${var.project2}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment2_type}"
  depends_on = ["agility_createproject.FinanceProject"]
}
resource "agility_createenvironment" "ProductionFinance"{
  parentprojectname="${var.project2}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.FinanceProject"]
}
resource "agility_createenvironment" "DevelopmentWindows"{
  parentprojectname="${var.project3}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.WindowsProject"]
}
resource "agility_createenvironment" "UATWindows"{
  parentprojectname="${var.project3}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment2_type}"
  depends_on = ["agility_createproject.WindowsProject"]
}
resource "agility_createenvironment" "ProductionWindows"{
  parentprojectname="${var.project3}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.WindowsProject"]
}
resource "agility_createenvironment" "DevelopmentLinux"{
  parentprojectname="${var.project4}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.LinuxProject"]
}
resource "agility_createenvironment" "UATLinux"{
  parentprojectname="${var.project4}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment2_type}"
  depends_on = ["agility_createproject.LinuxProject"]
}
resource "agility_createenvironment" "ProductionLinux"{
  parentprojectname="${var.project4}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.LinuxProject"]
}
resource "agility_createenvironment" "DevelopmentDotNet"{
  parentprojectname="${var.project5}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.DotNetProject"]
}
resource "agility_createenvironment" "UATDotNet"{
  parentprojectname="${var.project5}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment2_type}"
  depends_on = ["agility_createproject.DotNetProject"]
}
resource "agility_createenvironment" "ProductionDotNet"{
  parentprojectname="${var.project5}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.DotNetProject"]
}
resource "agility_createenvironment" "DevelopmentJava"{
  parentprojectname="${var.project6}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.JavaProject"]
}
resource "agility_createenvironment" "UATJava"{
  parentprojectname="${var.project6}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.JavaProject"]
}
resource "agility_createenvironment" "ProductionJava"{
  parentprojectname="${var.project6}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.JavaProject"]
}
resource "agility_createenvironment" "DevelopmentPython"{
  parentprojectname="${var.project7}"
  environment= "${var.environment1}"
  description="Environment created via terraform"
  environmenttype="${var.environment1_type}"
  depends_on = ["agility_createproject.PythonProject"]
}
resource "agility_createenvironment" "UATPython"{
  parentprojectname="${var.project7}"
  environment= "${var.environment2}"
  description="Environment created via terraform"
  environmenttype="${var.environment2_type}"
  depends_on = ["agility_createproject.PythonProject"]
}
resource "agility_createenvironment" "ProductionPython"{
  parentprojectname="${var.project7}"
  environment= "${var.environment3}"
  description="Environment created via terraform"
  environmenttype="${var.environment3_type}"
  depends_on = ["agility_createproject.PythonProject"]
}
