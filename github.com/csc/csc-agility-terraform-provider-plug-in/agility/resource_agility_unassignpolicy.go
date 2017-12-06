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

func resourceUnassignPolicy() *schema.Resource {

	return &schema.Resource{
		Create: resourceUnassignPolicyCreate,
		Read:   resourceUnassignPolicyRead,
		Update: resourceUnassignPolicyUpdate,
		Delete: resourceUnassignPolicyDelete,

		Schema: map[string]*schema.Schema{
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
			"policyname": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"policyid": &schema.Schema{
				Type:     schema.TypeString,
				Computed:   true,
				ForceNew:   true,
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

func resourceUnassignPolicyCreate(ResourceData *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceUnassignPolicyRead(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceUnassignPolicyDelete(d *schema.ResourceData, meta interface{}) error {
	credentials = meta.(ProvCredentials)
	//set up logging
	f, errf := os.OpenFile("./agility/api/agility.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if errf != nil {
		log.Println("error opening file: ", errf)
	}
	defer f.Close()

	log.SetOutput(f)
	projectName := d.Get("projectname").(string)
	log.Println("the Project name is: ", projectName)
	response, err := api.GetProjectId(string (projectName), credentials.UserName, credentials.Password)
	if err != nil {
		log.Println("Error in getting projectid: ", err)
		return err
	}
	d.Set("projectid",string(response))
	log.Println("the projectid is: ", string(response))
	projectId := d.Get("projectid").(string)

	api.UnassignPolicy(d,projectId,credentials.UserName,credentials.Password)

	return nil
}

func resourceUnassignPolicyUpdate(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

