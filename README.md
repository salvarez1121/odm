## Enabling OIDC Authentication on ODM

This will guide you through enabling OIDC authentication Azure AD via a helm install of ODM Decision Center and Decision Server Console. 

### Prereqs

- helm cli
- oc cli
- odm-aad-sso directory
- Free Azure Account: you just need an outlook account and sign in with those credentials @ https://portal.azure.com
- Azure Active Directory Instance
- internal postgres db
- ODM installed

## ODM Install ##
 
 Please 
 
 We will now add the urls as Redirect URIs to the Azure AD platform 


### Azure AD

**Prep-work**
 
 0. Create a new namespace for your odm project
 1. Put your cloudpak secret into this namespace
 2. Create the 'odm' service account (oc create sa odm)
 3. Edit the service account and add the cloudpak secret under imagePullSecret
    
    **oc edit sa odm**
     ```imagePullSecrets:
     - name: <image pull secret name>
	```
 4. Add the odm service account to the privileged scc (only need to do if using local postgres db container)
     
     **oc edit scc privileged**
 ```	
  - system:serviceaccount:<project name>:odm
 ```
	
 5. Create the oAuth 
      
      **oc create -f oAuth.yaml (in auth directory)**

## Azure AAD Configuration ##
 
 0. Login to your Azure AD instance
 1. Click on the Azure Service: Azure Active Directory
 2. Under manage click groups -> new group. Group type: Security, Group name: odmAdmins, -> Create
 
 ![](https://github.com/salvarez1121/odm/blob/main/images/Screen%20Shot%202021-12-10%20at%203.27.23%20PM.png)
 
 3. Now go back to default directory and click users -> new user. Give the user a username, name, and add him to the OdmAdmins group -> Create
 
 ![](https://github.com/salvarez1121/odm/blob/main/images/Screen%20Shot%202021-12-10%20at%203.28.22%20PM.png)
 
 2. Now go back to default directory and click on App Registrations -> + New registration
 
 ![](https://github.com/salvarez1121/odm/blob/main/images/Screen%20Shot%202021-12-10%20at%202.27.16%20PM.png)
 
 3. Add the name and click register. 
 
 ![](https://github.com/salvarez1121/odm/blob/main/images/Screen%20Shot%202021-12-10%20at%202.34.23%20PM.png)
 
 4. This will register the application and AAD will provide Essentials and Endpoints that we will use to configure the auth-secret
 
 ![](https://github.com/salvarez1121/odm/blob/main/images/Screen%20Shot%202021-12-10%20at%202.36.45%20PM.png)
 
 5. We will now create the client secret. Click on Certificates and Secrets -> New client Secret. Give it the name **odm-secret** and expiration date. 
 
 ![](https://github.com/salvarez1121/odm/blob/main/odm-aad-sso/images/Screen%20Shot%202021-12-10%20at%204.42.49%20PM.png)
 
 
 **authSecret Configuration**

 Now lets configure our auth-secret for OIDC deployment. We will need to edit the following configuration files within the auth directory with your AAD values:

 - **openIdParameters.properties**
 - **openIdWebSecurity.xml**
 - **webSecurity.xml**

 **keystoresecret Configuration**

 Add the following certificates to the truststore jks file via the keytool command. You can get these certificates clicking on the lock icon of your openshift and  azure url.  
 - OpenShift cluster certs
 - Azure AD certs

 ```keytool -keystore <jks file name> -storetype jks -importcert -file <file name> -alias server-certificate```
  **Password:changeme**

## AAD Authentication ##

 0. Go to your odm registered application and click the authentication tab. 
 1. Add platform -> Web -> Redirect URI: https://<route>/openid/redirect/odm 
 2. Enable Access Tokens and ID Tokens -> Configure
 3. Add the Redirect URI for the Decision Server Console/Decision Center
 
 ![](https://github.ibm.com/Salvador-Alvarez/odm/blob/master/odm-aad-sso/images/Screen%20Shot%202021-12-10%20at%205.02.41%20PM.png)

 Now you can click on the route within Openshift and test! 

 
 
