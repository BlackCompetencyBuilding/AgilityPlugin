package agility

import (
	"log"
	"os"
	"encoding/json"
	"github.com/csc/csc-agility-terraform-provider-plug-in/agility/api"
	"github.com/hashicorp/terraform/helper/schema"
)
/*type Container struct{
    XMLName struct{}    `xml:"container"`
    Name        string `xml:"name"`
    Description string  `xml:"description"`
}*/

func resourceCreatePackage() *schema.Resource {

	return &schema.Resource{
		Create: resourceCreatePackageCreate,
		Read:   resourceCreatePackageRead,
		Update: resourceCreatePackageUpdate,
		Delete: resourceCreatePackageDelete,

		Schema: map[string]*schema.Schema{
			"packagename": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				ForceNew:   true,
			},
			"packagedescription": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				ForceNew:   true,
			},
			"operatingsystem": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				ForceNew:   true,
			},
			"projectname": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"projectid": &schema.Schema{
				Type:       schema.TypeString,
				Computed:   true,
				ForceNew:   true,
			},
			"installscriptname1": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"installscriptname2": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"startupscriptname1": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"startupscriptname2": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"operationalscriptname1": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"operationalscriptname2": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"operationalscriptname3": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"operationalscriptname4": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
		},
	}
}

func init(){
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

	/*err2 := file.Close()
	log.Printf("err2: %v\n", err2)*/
}

func resourceCreatePackageCreate(ResourceData *schema.ResourceData, meta interface{}) error {
	credentials = meta.(ProvCredentials)
	//set up logging
	f, errf := os.OpenFile("./agility/api/agility.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if errf != nil {
		log.Println("error opening file: ", errf)
	}
	defer f.Close()

	log.SetOutput(f)
	projectName := ResourceData.Get("projectname").(string)
	log.Println("the Project name is: ", projectName)
	response, err := api.GetProjectId(string (projectName), credentials.UserName, credentials.Password)
	if err != nil {
		log.Println("Error in getting projectid: ", err)
		return err
	}
	ResourceData.Set("projectid",string(response))
	log.Println("the projectid is: ", string(response))
	projectId := ResourceData.Get("projectid").(string)

	api.CreatePackage(ResourceData, projectId, credentials.UserName, credentials.Password)
	return nil
}

func resourceCreatePackageRead(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceCreatePackageUpdate(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceCreatePackageDelete(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}
