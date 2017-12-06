variable "agility_userid" {}
variable "agility_password" {}
provider "agility" {
  userid = "${var.agility_userid}"
  password = "${var.agility_password}"
}

//License upload
/*resource "agility_license" "unlimited"{
}*/

//Create stack
/*
resource "agility_createstack" "stack" {
    projectname = "Agility Factory"
    imagename = "SOE-RHEL-6.5"
    stackname = "SOE-RHEL-6.5-Terraform"
    stackdescription = "SOE-RHEL-6.5-Terraform"
    operatingsystem = "Linux"
}
*/
//Add and sync cloud provider
/*resource "agility_addcloudprovider" "AWS" {
cloudname = "PM-AWS"
description = "Cloud provider created from terraform"
cloudtype = "Amazon EC2 Cloud"
hostname = "ec2.eu-west-1.amazonaws.com"
publickey = "AKIAJI4INTOM6BXDWR3A"
privatekey = "WfUf+j2fPB9VGg1qsWJxSMS0FUxnQrW+tSurofSC"
awsaccountnumber = "531227887946"
}
resource "agility_synccloudprovider" "SyncAWS" {
    cloudname = "PM-AWS"
    depends_on = [
        "agility_addcloudprovider.AWS"]
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

//Org Structure
/*resource "agility_createcontainer" "HRContainer" {
    parentcontainername = "Terraform"
    container = "HR"
    description = "Container created via terraform"
}
resource "agility_createcontainer" "FinanceContainer" {
    parentcontainername = "Terraform"
    container = "Finance"
    description = "Container created via terraform"
}
resource "agility_createcontainer" "ITContainer" {
    parentcontainername = "Terraform"
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
}*/


//create script
/*
resource "agility_createscript" "terraformscript1"{
  scriptname = "AgilityMonitorInstallTerraform"
  desc = "AgilityMonitorInstallTerraform"
  operatingsystem = "Linux"
  language = "bash"
  rebootrequired = "false"
  projectname = "Agility Factory"
  content = "AgilityMonitorInstallLinux"
  depends_on = ["agility_createstack.stack"]
}

resource "agility_createscript" "terraformscript2"{
    scriptname = "StartDetectionInstallTerraform"
    desc = "StartDetectionInstallTerraform"
    operatingsystem = "Linux"
    language = "bash"
    rebootrequired = "false"
    projectname = "Agility Factory"
    content = "StartDetectionInstallLinux"
    depends_on = ["agility_createscript.terraformscript1"]

}


resource "agility_createscript" "terraformscript3"{
    scriptname = "AgilityMonitorConfigTerraform"
    desc = "AgilityMonitorConfigTerraform"
    operatingsystem = "Linux"
    language = "bash"
    rebootrequired = "false"
    projectname = "Agility Factory"
    content = "AgilityMonitorConfigLinux"
  depends_on = ["agility_createscript.terraformscript2"]

}


resource "agility_createscript" "terraformscript4"{
  scriptname = "StartDetectionConfigTerraform"
  desc = "StartDetectionConfigTerraform"
  operatingsystem = "Linux"
  language = "bash"
  rebootrequired = "false"
  projectname = "Agility Factory"
  content = "StartDetectionConfigLinux"
  depends_on = ["agility_createscript.terraformscript3"]

}

resource "agility_createpackage" "terraformpackage"{
  projectname = "Agility Factory"
  packagename = "AgilityMonitorLinuxTerraform"
  packagedescription="AgilityMonitorLinuxTerraform"
  operatingsystem = "Linux"
  installscriptname1= "AgilityMonitorInstallTerraform"
  installscriptname2= "StartDetectionInstallTerraform"
  startupscriptname1="AgilityMonitorConfigTerraform"
  startupscriptname2="StartDetectionConfigTerraform"
  operationalscriptname1="AgilityMonitorInstallTerraform"
  operationalscriptname2="StartDetectionInstallTerraform"
  operationalscriptname3="AgilityMonitorConfigTerraform"
  operationalscriptname4="StartDetectionConfigTerraform"
  //shutdownscriptname1=""
  //shutdownscriptname2=""
  depends_on = ["agility_createscript.terraformscript4"]
}


resource "agility_firewall" "terraformfirewall"{
  projectname = "Agility Factory"
  firewallname = "CollectorFirewallTerraform"
  firewalldesc="CollectorFirewallTerraform"
  direction="Input"
  protocolprefix="0.0.0.0/0"
  protocolallowed="true"
  firewalltype="Firewall"

  protocolname1="HTTPS"
  protocoldesc1="HTTPS"
  protocolminport1="8443"
  protocolmaxport1="8443"
  protocol1="tcp"

  protocolname2="RealTimeMonitoring"
  protocoldesc2="RealTimeMonitoring"
  protocolminport2="2187"
  protocolmaxport2="2187"
  protocol2="tcp"

  protocolname3="AgilityMonitorTcp"
  protocoldesc3="AgilityMonitorTcp"
  protocolminport3="8649"
  protocolmaxport3="8649"
  protocol3="tcp"

  protocolname4="AgilityMonitorUdp"
  protocoldesc4="AgilityMonitorUdp"
  protocolminport4="8649"
  protocolmaxport4="8649"
  protocol4="udp"
 depends_on = ["agility_createpackage.terraformpackage"]
}
*/
/*
resource "agility_checkin" "checkinterraform"{
  containername="Root"
  headversionallowed="true"
  assetname="SOE-RHEL-6.5-Terraform"
  asset="blueprint"
  projectname="Agility Factory"
}


resource "agility_approve"  "approve"{
  projectname="Agility Factory"
  assetname="SOE-RHEL-6.5-Terraform"
  asset="blueprint"
  state="approve"
  comment="approved"
  depends_on = ["agility_checkin.checkinterraform"]
}
*/
/*resource "agility_headversion" "version" {
  asset="script"
  projectname="Agility Factory"
}
*/
/*
resource "agility_assignpolicy" "assignpolicyterraform"{
  projectname="Agility Factory"
  policyname="CollectorFirewallTerraform"
 depends_on = ["agility_firewall.terraformfirewall"]
}

resource "agility_blueprint" "createblueprintterraform"{

  projectname="Agility Factory"
  blueprintname="SOE-RHEL-6.5-Terraform"
  blueprintdesc="SOE-RHEL-6.5-Terraform"
  stackname="Ankit-new"
  packagename="AgilityMonitorLinuxTerraform"
  policyname="CollectorFirewallTerraform"
  headversionallowed="true"
  workloadname="Ankit-new"
  policyassignmentname="CollectorFirewallTerraform"
  depends_on = ["agility_assignpolicy.assignpolicyterraform"]

}

resource "agility_unassignpolicy" "unassignpolicyterraform"{
  projectname="Agility Factory"
  policyname="CollectorFirewallTerraform"
  depends_on = ["agility_blueprint.createblueprintterraform"]
}
*/

//as best practice we are publishing from root container
resource "agility_publish" "terraformblueprint" {
  productname="SOE-RHEL-6.5-Terraform"
  productdesc="SOE-RHEL-6.5-Terraform"
  producttype="blueprint"
  itemtype="blueprint"
  itemname="SOE-RHEL-6.5-Terraform"
  category="Featured Products"
  operatingsystem="Linux"
}
