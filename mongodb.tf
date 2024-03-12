# MongoDB has a weird setup: First, you download the CRDs as its own Helm chart, then you add another Helm Chart to manage instances, and then finally you can set up a CR to deploy an instance
resource "helm_release" "mongodb_crds" {
  depends_on = [kubernetes_namespace.misarch]
  name       = "mongodb-crds"
  repository = "https://mongodb.github.io/helm-charts"
  chart      = "community-operator-crds"
  namespace  = local.namespace
}
