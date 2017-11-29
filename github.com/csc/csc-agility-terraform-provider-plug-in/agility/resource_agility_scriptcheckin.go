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

func resourceScriptCheckIn() *schema.Resource {

	return &schema.Resource{
		Create: resourceScriptCheckinCreate,
		Read:   resourceScriptCheckinRead,
		Update: resourceScriptCheckinUpdate,
		Delete: resourceScriptCheckinDelete,

		Schema: map[string]*schema.Schema{
			"projectname": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"containername": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"projectid": &schema.Schema{
				Type:       schema.TypeString,
				Computed:   true,
				ForceNew:   true,
			},
			"containerid": &schema.Schema{
				Type:       schema.TypeString,
				Computed:   true,
				ForceNew:   true,
			},
			"scriptname": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"scriptid": &schema.Schema{
				Type:     schema.TypeString,
				Computed:   true,
				ForceNew:   true,
			},
			"headversionallowed": &schema.Schema{
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

func resourceScriptCheckinCreate(ResourceData *schema.ResourceData, meta interface{}) error {
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

	api.ScriptCheckIn(ResourceData,projectId,credentials.UserName,credentials.Password)

	return nil
}

func resourceScriptCheckinRead(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceScriptCheckinUpdate(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceScriptCheckinDelete(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

