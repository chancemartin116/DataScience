#Analytic Modeling    
    
This sample Python project creates a microservice of the [Kaplan-Meier](http://pages.stat.wisc.edu/~ifischer/Intro_Stat/Lecture_Notes/8_-_Survival_Analysis/8.2_-_Kaplan-Meier_Formula.pdf) estimator and deploys it to the Predix Analytics Catalog.  
__Note__: Before you can add and deploy an analytic, you must obtain a username and password to the catalog.
  
####Step1: Prepare the data  
The input data must be in json format.  The handleData directory contains a Python script that will convert csv files to json.  At the command line enter the following:
```shell
python csv_to_json.py <inputFile> <outputFile>
``` 

####Step2: Develop the analytic  
The analytic directory contains the code for the algorithm.  The output data also needs to be in json format.  The \_\_init\_\_.py file contains the import statement that allows the other scripts in the project to access the analytic functions.  The driver folder contains the code that calls the analytic in the cloud and returns the resulting output.  The config.json file specifies the directories and libraries used to deploy the analytic to the cloud.  
  
####Step3: Test the analytic locally
TestModeling.py runs the analytic locally before deploying to the cloud.  The outer \_\_init\_\_.py allows the test script to call the analytic.

####Step4: Add analytic to catalog
Once the analytic has successfully passed the local tests it can be added to the catalog.  First you must compress the analytic directory, driver directory and config.json into a zip file.  Then go to the [Predix Analytics](https://ids-sandbox.predix-analytics-ui-rc.grc-apps.svc.ice.ge.com/analytics/) catalog page and login.  On the next page select "New Analytic".  Fill in the different fields that describe the analytic. Then click the "Select a file to attach" button and select the zip file you created earlier.  Click the "Executable" checkbox and then click the "Save" button in the lower right corner.  

####Step5: Deploy and test the analytic  
Choose the "Deploy and Test" tab, copy your input json data and paste it in the available space and click the "Submit for Deployment and Test" button.  The analytic will start to deploy and the "Analytic Output" field will appear.  As the analytic is being processed you can click the "Refresh" button to see if the analytic was successfully deployed or is still processing.  You can also view the Cloud Foundry logs for the deployment by clicking the "Logs" tab.  Once it has finished, the output will appear in the "Analytic Output" field
