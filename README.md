## Installing ODM 
This guide will guide you through an installation of ODM containers on OpenShift on statefarm-2 directory. 
## Enabling OIDC Authentication on ODM

This will guide you through enabling OIDC authentication with 2 diffrent single-sign-on providers, RedHat SSO and Azure AD (odm-aad-sso) via a helm install of ODM Decision Center and Decision Server Console. 

## Enabling a Secure Route for your ODM Deployment
This will guide you through creating a secure URL with a signed certificate by a Certificate Authority.

## ODM Decision Server Runtime Rest calls and WS Calls
You will need to add to the authfilters xml file of the liberty server the following parameters 
under browserAuthFilter and apiAuthFilter:
- <requestUrl id="res3" matchType="notContain" urlPattern="/DecisionService/
under apiAuthFilter
- /DecisionService/|
