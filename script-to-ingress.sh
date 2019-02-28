#!/bin/bash
max=$(jq '.[] | length' config.json)
echo "apiVersion: extensions/v1beta1" > iafox-ingress.yaml
echo "kind: Ingress" >> iafox-ingress.yaml
echo "metadata:" >> iafox-ingress.yaml
echo "  name: test-iafox-com-ingress" >> iafox-ingress.yaml
echo "  annotations:" >> iafox-ingress.yaml
echo "    kubernetes.io/ingress.global-static-ip-name: ip-webapp-staging" >> iafox-ingress.yaml
echo "    certmanager.k8s.io/cluster-issuer: letsencrypt" >> iafox-ingress.yaml
echo "spec:" >> iafox-ingress.yaml
echo "  tls:" >> iafox-ingress.yaml
echo "  - hosts:" >> iafox-ingress.yaml
echo "    - '*.test.iafox.com'" >> iafox-ingress.yaml
echo "    secretName: test-iafox-com-letsencrypt" >> iafox-ingress.yaml
echo "  rules:" >> iafox-ingress.yaml
echo "  - host: helloweb.test.iafox.com" >> iafox-ingress.yaml
echo "    http:" >> iafox-ingress.yaml
echo "      paths:" >> iafox-ingress.yaml
echo "      - path: /*" >> iafox-ingress.yaml
echo "        backend:" >> iafox-ingress.yaml
echo "          serviceName: helloweb-backend" >> iafox-ingress.yaml
echo "          servicePort: 8080" >> iafox-ingress.yaml

i=0
echo "--------------------------------------"
echo "======= VALUES FROM CONFIG.JSON ======="
echo "--------------------------------------"
while [ $i -lt $max ]
do
    CUSTOMER=$(jq -r '.[] | .['$i'] | .name' config.json)
    echo "name: $CUSTOMER"
    echo "  - host: $CUSTOMER.test.iafox.com" >> iafox-ingress.yaml
    echo "    http:" >> iafox-ingress.yaml
    echo "      paths:" >> iafox-ingress.yaml
    echo "      - path: /*" >> iafox-ingress.yaml
    echo "        backend:" >> iafox-ingress.yaml
    echo "          serviceName: $CUSTOMER-svc" >> iafox-ingress.yaml
    echo "          servicePort: 80" >> iafox-ingress.yaml
    echo "      - path: /firmware/*" >> iafox-ingress.yaml
    echo "        backend:" >> iafox-ingress.yaml
    echo "          serviceName: bucket-proxy-backend" >> iafox-ingress.yaml
    echo "          servicePort: 80" >> iafox-ingress.yaml
#    kubectl apply -f customers/iafox-$CUSTOMER.yaml

    let i++

    echo "--------------------------------------"
done
# kubectl apply -f iafox-ingress.yaml
