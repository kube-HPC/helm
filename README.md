# kubernetes helm charts for hkube

 Installing form helm charts  
1. Installing first thiredparty 
   'helm install --name thiredparty  hkube/charts/thirdParty'   

2. Installing core 
   'helm install -f hkube/charts/core/version.yaml --name core hkube/charts/core/'

