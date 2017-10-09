package agility

import (
	"log"
	"strings"
	"os"
	//"encoding/json"

	"github.com/csc/csc-agility-terraform-provider-plug-in/agility/api"
	"github.com/hashicorp/terraform/helper/schema"

	"encoding/json"


)

type SMLicense struct{
	XMLName struct{}    `"SMLicense"`
	XMLNS 		string `"xmlns,attr,omitempty"`
	LicenseVersion 	string	`"LicenseVersion"`
	Licensee		string	`"Licensee"`
	NumberOfClients	string	`"NumberOfClients"`
	MaxPermittedInstances	string `"MaxPermittedInstances"`
	DBQueryType		string	`"DBQueryType"`
	Signature		string 	`"Signature"`
}
type Adapters struct{
	XMLName struct{}    `"Adapters"`
	Adapter string		`"Adapter"`

}
type Modules struct{
	XMLName struct{}    `"Modules"`
	Module string		`"Module"`
}
type IssueDate struct{
	XMLName struct{}	`"IssueDate"`
	IssueDay	string	`"IssueDay"`
	IssueMonth	string	`"IssueMonth"`
	IssueYear	string	`"IssueYear"`
}
type ExpiryDate struct{
	XMLName struct{}	`"ExpiryDate"`
	ExpiryDay	string	`"ExpiryDay"`
	ExpiryMonth	string	`"ExpiryMonth"`
	ExpiryYear	string	`"ExpiryYear"`
}
type ServerNodeLock struct{
	XMLName struct{}	`"ServerNodeLock"`
	Mask	string	`"Mask"`
	IPAddr	string	`"IPAddr"`
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
				ForceNew:	true,

			},
			"licensee": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,
			},
			"adapter": &schema.Schema{
				Type:     schema.TypeString,
				Required: true,
				ForceNew:	true,
			},
			"module": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"issueday": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"issuemonth": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"issueyear": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"expiryday": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"expirymonth": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"expiryyear": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"numberofclients": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"maxpermittedinstances": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"mask": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"ipaddr": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"dbquerytype": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
			"signature": &schema.Schema{
				Type:     schema.TypeString,
				Required: 	true,
				ForceNew:	true,

			},
		},
	}
}


func init() {
	file, err1 := os.Open("./agility/api/conf.json")
	if err1 != nil {
		log.Println("error:", err1)
	}
	decoder := json.NewDecoder(file)
	configuration = Config{}
	err := decoder.Decode(&configuration)
	if err != nil {
		log.Println("error:", err)
	}
}

func LicenseUpload(ResourceData *schema.ResourceData, meta interface{}) error {
	credentials = meta.(ProvCredentials)
	f, errf := os.OpenFile("./agility/api/agility.log", os.O_RDWR | os.O_CREATE | os.O_APPEND, 0666)
	if errf != nil {
		log.Println("error opening file: ", errf)
	}
	defer f.Close()
	log.SetOutput(f)

	licenseresponse := api.LicenseUpload(credentials.UserName, credentials.Password)
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
