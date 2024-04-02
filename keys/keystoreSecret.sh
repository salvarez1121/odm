oc delete secret keystore-secret
oc create secret generic keystore-secret --from-literal=keystore_password=changeme --from-file=keystore.jks=keystore.jks --from-literal=truststore_password=changeme --from-file=truststore.jks=truststore.jks
