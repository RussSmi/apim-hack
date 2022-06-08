# API Management IaC Mini Hack - (Alpha)

## Welcome

Welcome to the APIM - IaC Mini Hack
This repo came about following a number of customer demos of Azure DevOps from an app innovation perspective.
API Management was chosen because it is a good example where multiple teams will be responsible for deployments to it.  For example there may be a platform team managing an organisations infrastructure or integration platform, and there would be development teams who actually create and deploy APIs.

## Overview

In the future there will a desription of a company here with a scenario detailing why they are considering using Azure API Management and what they want to do with it.  I look forward to receiving some interesting pull requests for that!

There will be two teams in this ficticious company working on this solution as mentioned above.  The Platform Team and the Dev Team.  The Dev team need an APIM instance to work with so they can deploy an API that will be used by one of the company's apps.

There will follow below a sequence of steps that should be followed.  It is suggested that this hack can be followed in one of three ways:

1. Hardcore - start completely from scratch using any means you like
2. Kickstarter - follow the steps using Bicep and ADO with some starter components created in advance
3. Cheater - just deploy one possible solution - assuming I get around to creating one.

A solution will ultimately be crearted in the solution folder, starter artefacts in the starter folder.  To get started, just follow the steps below...

## Steps

### Step 1 - Create APIM Instance (Platform Team)

Using an IaC language of your choice, create an APIM instance for our fictiious company. A CI/CD approach must be used right from the start, with code in a repo and automated deployments. There are some typical organisational requirements around this:

* Users only have read access to target environments so a pipeline with a appropriate identity must be used
* Initially just dev environment will be targetted but this will be extended later so no hardcoded values must be used.
* It is not yet known if this will be the only APIM our company will use so a modular approach is required.
* This will be demo'd to the company SLT so the deployment needs to be fast (this will help you choose the tier).

### Step 2 - Deploy an API (Development Team)

We need to expose an API through API management by creating an API with a single GET operation.  The URL for the API is <https://serverlessohapi.azurewebsites.net/api/GetUsers> (This is one of the test APIs used by the Serverless Openhack)

Points to note:

* In the future there will be policies edited by non developers, these changes should not change the API bicep code
* It should be possible to test the backend api and deployed changes through VS Code.

### Step 3 - Deploy to multiple environments (DevOps)

Our demo to the SLT was a great success so now we need to deploy API Instance and the APIs to test and production environments.  Deployment to Dev should be automatic, Test and Prod will require an approval.

### Step 4 - An urgent change request (Development Team)

The consumer of our API has had a retro moment after going to see Abba Voyage.  They now want the list of users to be returned as XML.  Show how the full devlopment lifecycle can be used to ripple the change through to Prod.  

During the customer demo version of this we showed the following:

* Create a work item in ADO with new branch
* Pull branch in VS Code, make change to the policy XML File
* Commit change, push and PR into main branch
* Show APIS pipeline triggering and deploying to Dev
* Test Dev from VS code with REST client, show Dev returns XML, test and prod still return JSON
* Approve change in Test, retest.  Same for Prod

