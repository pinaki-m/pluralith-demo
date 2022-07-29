## What is this project about?
This project creates a pipeline using Github Actions and implements Infracost and Pluralith to get changes to cost estimate and Infrastructure architecture as part of a PR. Wenever a PR is raised for the **main** branch, the pipeline add cost information and infrastructure diagram to to the PR comments. 

**Following is an example of how the cost information looks** <br>
The Infracost run of the pipeline adds information in the PR comments that provide a view of the change in cost estimates that the PR will make.

<img width="930" alt="Infracost" src="https://user-images.githubusercontent.com/12571181/180637189-fdd14f68-ae39-4494-bed1-63874f594d8e.png">

**Following is an example of how the infrastructure diagram looks**<br>
The Pluralith run of the pipeline adds information in the PR comments that provide a view of the infrastructure changes that the PR will make and provides a view of the infrastructure's created, updated, destroyed, recreated, and drifted components. 

<img width="960" alt="Pluralith" src="https://user-images.githubusercontent.com/12571181/180637202-eb88276d-4c6a-4a69-9a21-41f98e07e694.png">

**Following is an example of how the infrastructure diagram in the README section looks**<br>
## Infrastructure Diagram
[![Pluralith Run Status](https://api.pluralith.com/v1/docs/460944046/status)](https://pluralith.com)<br></br>[![Pluralith Last Diagram](https://api.pluralith.com/v1/docs/460944046/diagram)](https://app.pluralith.com/#/orgs/202246319/projects/460944046/runs)


## What accounts do you need?
In order to run this solution you will need accounts in the following tools. For personal use in public repos all these are free of cost except AWS (if you are not using the free tier)

* [AWS Account](https://aws.amazon.com/)
* [Terraform Cloud](https://app.terraform.io/)
* [Pluralith](https://www.pluralith.com/)
* [InfraCost](https://www.infracost.io/)
* [Github](https://github.com/)

## What do you need from these accounts?

In order to tie all the pieces of the component together you will need some information from each of these accounts which you need to add to the repository secrets of Github.

* AWS Account *(Login credentials of the identity you will be using)*
	* 	AWS_ACCESS\_KEY\_ID 
	*  AWS_SECRET\_ACCESS\_KEY
* Terraform Cloud
	* 	TF\_API_TOKEN *(In Terraform Cloud, go to User settings >> tokens. Press the "Create an API Token" button. Copy the API token just created.)*
* Pluralith
	* 	PLURALITH\_API_KEY *(In Pluralith, go to "Account Settings", copy the API Key.)*
	*  PLURALITH\_PROJECT_ID *(In Pluralith, go to Projects. Open the project you will be using for the run. Go to Settings. Copy the project ID.)*	
* InfraCost
	* 	INFRACOST\_API_KEY *(Refer to the [Infracost documentation](https://www.infracost.io/docs/) to retreive the API Key)*

## List of all the secrets that you need to add to Github

Following is the complete list of all the secrets that you need to add to Github

* 	AWS_ACCESS\_KEY\_ID
*  AWS_SECRET\_ACCESS\_KEY
* 	TF\_API_TOKEN
* 	PLURALITH\_API_KEY
*  PLURALITH\_PROJECT_ID
* 	INFRACOST\_API_KEY
*  INFRACOST_CURRENCY *(The currency in which you want the cost enstimates in.)*

## Important settings

* **Terraform Cloud** :- In a remote execution mode Terraform Cloud does not allow download of the state to local, hence the Pluralith component fails. To fix this, in Terraform Cloud, go to your workspace >> Settings >> General Settings. Change execution mode from Remote to Local. 
* **main.tf** :- This file has information about the Terraform Cloud organization and workspace at the top. You need to change this to point to your organization and workspace.  
