oc delete secret auth-secret
oc create secret generic auth-secret --from-file=openIdWebSecurity.xml=openIdWebSecurity.xml --from-file=openIdParameters.properties=openIdParameters.properties --from-file=webSecurity.xml=webSecurity.xml --from-file=group-security-configurations.xml
