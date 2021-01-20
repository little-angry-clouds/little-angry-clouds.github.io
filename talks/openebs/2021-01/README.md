# Openebs
La presentación está disponible [aquí](https://little-angry-clouds.github.io/talks/openebs/2021-01/index.html). Y el código de la POC, [aquí](https://github.com/little-angry-clouds/little-angry-clouds.github.io/tree/master/talks/openebs/2021-01/code).

Para aplicar el código hace falta:
- Terraform instalado, versión >14
- Cuenta de AWS
- Credenciales de AWS como variables de entorno

Se despliega un VPC con 3 redes privadas y 3 públicas, cada una en 3 az diferentes, con un Nat GW. 

**Aplicar este código de terraform conllevará costes en tu cuenta.**

``` bash
cd code
terraform apply 
# yes
export KUBECONFIG=kubeconfig_openebs-poc
kubectl get pods
```
