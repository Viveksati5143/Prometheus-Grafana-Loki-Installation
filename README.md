## Makefile 

Makefiles are used to help decide which parts of a large program need to be recompiled.

Make can be installed from [here](https://stackoverflow.com/a/73862277/20540922) (Optional)*

## After installing Prometheus, Grafana & Loki you can fetch logs following the below steps:
    
1. Run in terminal:
   
        kubectl get svc - grafana

2. Copy dns name & run in the browser

3. Add id & pass in the dashboard
   
   1. fetch pass in form of secret key using:
      
            kubectl get secret --namespace <name> grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

5. Add data source -> loki by replacing url with -

        http://loki:3100

7. Click on Explore -> data source

8. Select Loki

9. Click on type -> choose app 

10. Click on name -> choose <pod name> to fetch logs from 

11. Run query

## Conclusion
   
   logs fetched successfully using loki of all deployed pods, service.
