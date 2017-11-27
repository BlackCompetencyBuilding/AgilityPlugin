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

func resourceCreateStack() *schema.Resource {

	return &schema.Resource{
		Create: resourceCreateStackCreate,
		Read:   resourceCreateStackRead,
		Update: resourceCreateStackUpdate,
		Delete: resourceCreateStackDelete,

		Schema: map[string]*schema.Schema{
			"projectname": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"imagename": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				Computed:   false,
			},
			"projectid": &schema.Schema{
				Type:       schema.TypeString,
				Computed:   true,
				ForceNew:   true,
			},
			"imageid": &schema.Schema{
				Type:       schema.TypeString,
				Computed:   true,
				ForceNew:   true,
			},
			"stackname": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				ForceNew:   true,
			},
			"stackdescription": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
				ForceNew:   true,
			},
			"operatingsystem": &schema.Schema{
				Type:     schema.TypeString,
				Required:   true,
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

func resourceCreateStackCreate(ResourceData *schema.ResourceData, meta interface{}) error {
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


	imageName := ResourceData.Get("imagename").(string)
	log.Println("the image name is: ", imageName)
	response1, err := api.GetImageId(string (imageName), credentials.UserName, credentials.Password)
	if err != nil {
		log.Println("Error in getting imageid: ", err)
		return err
	}
	ResourceData.Set("imageid",string(response1))
	log.Println("the imageid is: ", string(response1))
	imageId := ResourceData.Get("imageid").(string)


	api.CreateStack(ResourceData, projectId, imageId, credentials.UserName, credentials.Password)
	return nil
}

func resourceCreateStackRead(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceCreateStackUpdate(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}

func resourceCreateStackDelete(d *schema.ResourceData, meta interface{}) error {
	// no need to do anything for read state

	return nil
}
