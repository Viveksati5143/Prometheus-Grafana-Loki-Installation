## Makefile 

Makefiles are used to help decide which parts of a large program need to be recompiled.

Make can be installed from [here](https://stackoverflow.com/a/73862277/20540922) (Optional)*

## After installing Prometheus, Grafana & Loki you can fetch logs following the below steps:
    
    1. Run: kubectl get svc - grafana

    2. Copy dns name & run in the browser

    3. Add id & pass in the dashboard
        fetch pass in form of secret key using: 	
            kubectl get secret --namespace <name> grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

    4. Add data source -> loki by replacing url with - ```http://loki:3100```

    5. Click on Explore -> data source

    6. Select Loki

    7. Click on type -> choose app 

    8. Click on name -> choose <pod name> to fetch logs from 

    9. Run query

## Conclusion
   
   logs fetched successfully using loki of all deployed pods, service.