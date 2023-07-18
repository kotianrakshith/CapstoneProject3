
# **Capstone project – Hotel-Side Hospital**

**Objective**: To create an automated provisioned infrastructure using Terraform, EKS cluster, EC2 instances, and Jenkins server.

**Tools to use:**

1. Jenkins
2. Terraform
3. AWS EC2
4. AWS EKS

**Description**

Hotel-Side Hospital, a globally renowned hospital chain headquartered in  Australia, is aiming to streamline its operation by setting up an  infrastructure within the hotel premises. However, in order to maintain  seamless functioning and scalability, they require fully managed virtual  machines (VMs) on the Amazon Web Services (AWS) platform. 

The organization seeks an automated provisioned infrastructure solution  that can enable them to effortlessly create new Amazon Elastic Kubernetes  Service (EKS) clusters, whenever required, and promptly delete them when  they are no longer needed. This will optimize resource allocation and  enhance operational efficiency

**Task (Activities)**

1. Validate if Terraform is installed in the virtual machine 
2. Install AWS CLI 
3. Navigate to AWS IAM service, and get AWS Access key and Secret Key to  connect AWS with the AWS CLI 
4. Export the AWS Access Key, Secret Key, and Security Token to configure  AWS CLI connectivity with AWS Cloud 
5. Create terraform scripts to create a new VM using autoscaling which  includes the following files: autoscaling.tf, VPC.tf, internetgateway.tf,  subnets.tf (public subnet), routetable.tf,  Route\_table\_association\_with\_public\_subnets.tf  
6. Execute terraform scripts 
7. Connect to an instance and install the stress utility (The stress files are  provided along with the problem statement document.) 
8. Validate if autoscaling is working by putting load on autoscaling group 



**Steps performed:**

## **1. Validate if Terraform is installed in the virtual machine :**

To check if the terrform is installed we can use the command

`terraform --version`

As we can see it is already installed:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.001.png)

Since the terraform is old version we need to install the new version. From the terraform website we get below commands to download and install terraform in our machine:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.002.png)
```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb\_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform
```
Now if we check we can see that terraform is at the newest version

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.003.png)

## *2. Install AWS CLI** 

To install the AWS CLI run the below commands:

(all the commands are taken from amazon official documentation)
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86\_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install
```
But as we already have cli in the system pre installed it gave the below error

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.004.png)

We can check the version using command:

`aws --version`

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.005.png)

We will upgrade this also using upgrade command:

`sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update`

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.006.png)

As you can see it is upgraded.

## **3. Navigate to AWS IAM service, and get AWS Access key and Secret Key to  connect AWS with the AWS CLI**

We will go to AWS IAM and then users, here we will create a user by clicking Add user button:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.007.png)

We give a name:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.008.png)

In permissions we will give administrator access:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.009.png)

Then you create the user.

Once you create go to the users security credentials:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.010.png)

Here you should see access keys option, here click Create access key:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.011.png)

Chose your use case:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.012.png)

Once you create you will get the access key and the secret access key

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.013.png)

Copy both the access key and the secret access key and save it securely.

## **4. Export the AWS Access Key, Secret Key to configure  AWS CLI connectivity with AWS Cloud**

Now we can configure aws on our system by command:

`aws confirgure`

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.014.png)

We can see that it is configured

Please note that you have to configure it also in the jenkins user as jenkins uses this user:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.015.png)

## **5. Setup Git and Github for storing the files.**

First we are creating a new githut repository to store the link:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.016.png)

Now we will clone this account and start using this account and upload all the script files here:

Create a directory:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.017.png)	

We recieved an access error while cloning, so to solve the error we will generate a public key and add it to git hub.

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.018.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.019.png)

Add the key in the ssh section of the settings of github:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.020.png)

Once added we can clone:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.021.png)

Now you can see that we have local working repo for the remote repo

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.022.png)

## **6. Create terraform scripts to create a new VM using auto scaling:**

First we will create *providers.tf* file and we will add below code:

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/providers.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.023.png)

Now we create the *vpc.tf* for the VPC

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/vpc.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.024.png)

Now let us create three subnets with the file name *subnets.tf:*

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/subnets.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.025.png)

As of now we have created vpc, subnets terraform file:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.026.png)

Now let us create internte gate terraform file: *internetgateway.tf*

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/internetgateway.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.027.png)

Now let us create the route table:*routetable.tf*

In this below code we will allow the route of all the internet(0.0.0.0/0)

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/routetable.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.028.png)

Now we will have to do the route table association as the route table needs to be connected with all the public subnets:

We will use the file : 

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/Route_table_association_with_public_subnets.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.029.png)

Now we have to do secrity groups before we got to autoscaling

*securitygroup.tf*

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/securitygroup.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.030.png)

Now we will create *autoscaling.tf*

This will have launch template and autoscaling group required for creation and scaling of the VMs:

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/autoscaling.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.031.png)

Now that we have created all the files:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.032.png)

Lets push it to github:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.033.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.034.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.035.png)

Push:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.036.png)

Now we can see all the files in the github repository:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.037.png)

This is only for highly availble ec2 instance.

Now we need to write one more for EKS cluster

For EKS cluster to work first we need to create a role for both eks cluster and nodes and then add proper policies for the same

So first we will create terraform file for this: *rolepolicy.tf*

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/rolepolicy.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.038.png)

Then we will create the eks cluser and node in the file : *eks.tf*

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/eks.tf>

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.039.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.040.png)

Now we will add , commit and push this also to github

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.041.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.042.png)

Now we have all the files in the github:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.043.png)

## **7. Execute terraform scripts:**

We will use jenkins to checkout the github repository and execute the terrraform commands.

First in the jenkins we will install terraform plugin:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.044.png)

Also in the global tool configuration add terraform details:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.045.png)

Now we will can write the checkout and apply as steps in the pipline

Create new pipeline project in jenkins

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.046.png)

Give proper description and provide git hub project url:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.047.png)

To get the checkout script we will use pipeline syntax

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.048.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.049.png)

So we add the script we generate in the checkout stage:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.050.png)

Now we add init and apply stage to the pipeline as well

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.051.png)

Now we have the final script:

<https://github.com/kotianrakshith/CapstoneProject3/blob/main/Jenkinsfile>

We can save this as Jenkinsfile in the git so it can be used easily for the future.

Once saved we click on build now to start the pipeline:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.052.png)

We can see that it has run successfully:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.053.png)

## **8. Checking the deployment in AWS:**

We see in the autoscaling groups that there are two autoscaling groups, one for EKS and one for EC2 as we correctly deployed:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.054.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.055.png)

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.056.png)

Each have one instance.

## **9. Connect to an instance and install the stress utility:**

We will connect to one of the instance:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.057.png)

Here we will install the stress tool:

`sudo yum install stress -y`

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.058.png)

## **10. Validate if autoscaling is working by putting load on autoscaling group:**

Now we will run the stress command to put load on the system:

`sudo stress --cpu 8 -v --timeout 3000s`

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.059.png)

After we run for some time let us check the CPU utlization:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.060.png)

Cpu utlization is more than our  limit.

Now if we check the autoscaling group:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.061.png)

We can see that 3 instance has been deployed as it is our max limit.

Now let us stop the stress test and wait:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.062.png)

We can see that cpu utlization falls eventually to zero

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.063.png)

Now the instance has decreased to two:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.064.png)

Eventually we will have only one:

![](/readmeimages/Aspose.Words.87b604ea-6f5d-4a91-a80b-8c6d0b6be376.065.png)

So we have confimed that autoscaling works.

That concludes our project. As per the project we deployed EC2 instances and EKS with autoscaling and we checked that autoscaling works after we performed the stress test.
