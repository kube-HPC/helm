# kubernetes helm charts for hkube

 Installing and Deleteting hkube with helm charts
 
1. Installing full cluster.
   Change the vales in values.yaml to:
    thirdparty:
      enabled: true
    and 
    minikube:
      enabled: false  
    and 
    pipeline-driver:
      replicaCount: 20
    and then run:
   'helm install --name hkube  hkube'

2. Installing minikube version 
   Change the vales in values.yaml to:
    thirdparty:
      enabled: false
    and 
    minikube:
      enabled: true  
    and 
    pipeline-driver:
      replicaCount: 1
    and then run: 
    'helm install --name hkube  hkube'
3. Deleteing. 
   'helm del --purge hkube'
