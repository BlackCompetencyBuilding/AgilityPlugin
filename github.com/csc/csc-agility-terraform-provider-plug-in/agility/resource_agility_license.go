package agility

import (
	"log"
	"strings"
	"os"
	//"encoding/json"

	"github.com/csc/csc-agility-terraform-provider-plug-in/agility/api"
	"github.com/hashicorp/terraform/helper/schema"

)

type SMLicense struct{
	XMLName struct{}    "SMLicense"
	XMLNS 		string "xmlns,attr,omitempty"
	LicenseVersion 	string	"LicenseVersion"
	Licensee		string	"Licensee"
	NumberOfClients	string	"NumberOfClients"
	MaxPermittedInstances	string"MaxPermittedInstances"
	DBQueryType		string	"DBQueryType"
	Signature		string 	"Signature"
}
type Adapters struct{
	XMLName struct{}    "Adapters"
	Adapter string		"Adapter"

}
type Modules struct{
	XMLName struct{}    "Modules"
	Module string		"Module"
}
type IssueDate struct{
	XMLName struct{}	"IssueDate"
	IssueDay	string	"IssueDay"
	IssueMonth	string	"IssueMonth"
	IssueYear	string	"IssueYear"
}
type ExpiryDate struct{
	XMLName struct{}	"ExpiryDate"
	ExpiryDay	string	"ExpiryDay"
	ExpiryMonth	string	"ExpiryMonth"
	ExpiryYear	string	"ExpiryYear"
}
type ServerNodeLock struct{
	XMLName struct{}	"ServerNodeLock"
	Mask	string	"Mask"
	IPAddr	string	"IPAddr"
}

func resourceLicenseUpload() *schema.Resource {

	return &schema.Resource{
		Create: LicenseUpload,
		Read: 	LicenseUploadRead,
		Delete:	LicenseUploadDelete,


		Schema: map[string]*schema.Schema{
			"licenseversion": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"licensee": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"adapters": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"modules": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"issueday": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"issuemonth": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"issueyear": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"expiryday": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"expirymonth": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"expiryyear": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"numberofclients": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"maxpermittedinstances": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"mask": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"ipaddr": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"dbquerytype": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
			"signature": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				Computed: 	false,
				ForceNew:	true,
			},
		},
	}
}

func LicenseUpload(ResourceData *schema.ResourceData, meta interface{}) error {
	f, errf := os.OpenFile("./agility/api/agility.log", os.O_RDWR | os.O_CREATE | os.O_APPEND, 0666)
	if errf != nil {
		log.Println("error opening file: ", errf)
	}
	defer f.Close()

	log.SetOutput(f)
	licenseresponse, _ := api.LicenseUpload(credentials.UserName, credentials.Password)
	r := strings.NewReader(string(licenseresponse))
	log.Println("Deploy response is : ", r)

	return nil
}

func LicenseUploadRead(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}
func LicenseUploadDelete(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}
