output "Image_deployed" {
    value = "${kubernetes_deployment.container.spec.0.template.0.spec.0.container.0.image}"
}

output "Deployment_Address" {
  value = kubernetes_service.loadbalancer.load_balancer_ingress[0].ip
}