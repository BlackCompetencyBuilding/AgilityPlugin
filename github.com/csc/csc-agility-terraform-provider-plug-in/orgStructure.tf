variable "agility_userid" {}
variable "agility_password" {}
provider "agility" {
    userid = "${var.agility_userid}"
    password = "${var.agility_password}"
}
# Create a new Linux instance on a small server
/*resource "agility_compute" "myserver" {
    name = "myserver"
    active = "true"
    version = "1"
    type = "t1.micro"
    blueprint = "SOE-RHEL-6.7"
    environment = "Development"
    project = "StackImportSOE"
}*/
resource "agility_createcontainer" "HRContainer" {
  parentcontainername = "Group1A"
  container = "HR"
  description = "Container created via terraform"
}
resource "agility_createcontainer" "FinanceContainer" {
  parentcontainername = "Group1A"
  container = "Finance"
  description = "Container created via terraform"
}
resource "agility_createcontainer" "ITContainer" {
  parentcontainername = "Group1A"
  container = "IT"
  description = "Container created via terraform"
}
resource "agility_createcontainer" "SubHRContainer" {
  parentcontainername = "HR"
  container = "SubHR"
  description = "Container created via terraform"
  depends_on = ["agility_createcontainer.HRContainer"]
}
resource "agility_createcontainer" "AdminContainer" {
  parentcontainername = "IT"
  container = "Admin"
  description = "Container created via terraform"
  depends_on = ["agility_createcontainer.ITContainer"]
}
resource "agility_createcontainer" "DeveloperContainer" {
  parentcontainername = "IT"
  container = "Developer"
  description = "Container created via terraform"
  depends_on = ["agility_createcontainer.ITContainer"]
}
resource "agility_createproject" "HRProject"{
  parentcontainername="SubHR"
  project="HR"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.SubHRContainer"]
}
resource "agility_createproject" "FinanceProject"{
  parentcontainername="Finance"
  project="Finance"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.FinanceContainer"]
}
resource "agility_createproject" "WindowsProject"{
  parentcontainername="Admin"
  project="Windows"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.AdminContainer"]
}
resource "agility_createproject" "LinuxProject"{
  parentcontainername="Admin"
  project="Linux"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.AdminContainer"]
}
resource "agility_createproject" "DotNetProject"{
  parentcontainername="Developer"
  project="DotNet"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.DeveloperContainer"]
}
resource "agility_createproject" "JavaProject"{
  parentcontainername="Developer"
  project="Java"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.DeveloperContainer"]
}
resource "agility_createproject" "PythonProject"{
  parentcontainername="Developer"
  project="Python"
  description="Project created via terraform"
  depends_on = ["agility_createcontainer.DeveloperContainer"]
}
resource "agility_createenvironment" "DevelopmentHR"{
  parentprojectname="HR"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.HRProject"]
}
resource "agility_createenvironment" "UATHR"{
  parentprojectname="HR"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.HRProject"]
}
resource "agility_createenvironment" "ProductionHR"{
  parentprojectname="HR"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.HRProject"]
}
resource "agility_createenvironment" "DevelopmentFinance"{
  parentprojectname="Finance"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.FinanceProject"]
}
resource "agility_createenvironment" "UATFinance"{
  parentprojectname="Finance"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.FinanceProject"]
}
resource "agility_createenvironment" "ProductionFinance"{
  parentprojectname="Finance"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.FinanceProject"]
}
resource "agility_createenvironment" "DevelopmentWindows"{
  parentprojectname="Windows"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.WindowsProject"]
}
resource "agility_createenvironment" "UATWindows"{
  parentprojectname="Windows"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.WindowsProject"]
}
resource "agility_createenvironment" "ProductionWindows"{
  parentprojectname="Windows"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.WindowsProject"]
}
resource "agility_createenvironment" "DevelopmentLinux"{
  parentprojectname="Linux"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.LinuxProject"]
}
resource "agility_createenvironment" "UATLinux"{
  parentprojectname="Linux"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.LinuxProject"]
}
resource "agility_createenvironment" "ProductionLinux"{
  parentprojectname="Linux"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.LinuxProject"]
}
resource "agility_createenvironment" "DevelopmentDotNet"{
  parentprojectname="DotNet"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.DotNetProject"]
}
resource "agility_createenvironment" "UATDotNet"{
  parentprojectname="DotNet"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.DotNetProject"]
}
resource "agility_createenvironment" "ProductionDotNet"{
  parentprojectname="DotNet"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.DotNetProject"]
}
resource "agility_createenvironment" "DevelopmentJava"{
  parentprojectname="Java"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.JavaProject"]
}
resource "agility_createenvironment" "UATJava"{
  parentprojectname="Java"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.JavaProject"]
}
resource "agility_createenvironment" "ProductionJava"{
  parentprojectname="Java"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.JavaProject"]
}
resource "agility_createenvironment" "DevelopmentPython"{
  parentprojectname="Python"
  environment= "Dev"
  description="Environment created via terraform"
  environmenttype="DEV"
  depends_on = ["agility_createproject.PythonProject"]
}
resource "agility_createenvironment" "UATPython"{
  parentprojectname="Python"
  environment= "UAT"
  description="Environment created via terraform"
  environmenttype="UAT"
  depends_on = ["agility_createproject.PythonProject"]
}
resource "agility_createenvironment" "ProductionPython"{
  parentprojectname="Python"
  environment= "Production"
  description="Environment created via terraform"
  environmenttype="PROD"
  depends_on = ["agility_createproject.PythonProject"]
}


