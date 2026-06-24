{
  Ingress(name, namespace, host, serviceName, servicePort, tlsSecret=null, authelia=false):: {
    apiVersion: 'networking.k8s.io/v1',
    kind: 'Ingress',
    metadata: {
      name: name,
      namespace: namespace,
      annotations: {
        'traefik.ingress.kubernetes.io/router.entrypoints': 'websecure',
        'traefik.ingress.kubernetes.io/router.tls': true,
        'cert-manager.io/cluster-issuer': 'letsencrypt-prod',
        'traefik.ingress.kubernetes.io/redirect-entry-point': 'https',
        'traefik.ingress.kubernetes.io/redirect-permanent': 'true',
      } + (if authelia == true then {
             'traefik.ingress.kubernetes.io/router.middlewares': 'authelia-authelia-forwardauth@kubernetescrd',
           } else {}),
    },
    spec: {
      rules: [{
        host: host,
        http: {
          paths: [
            {
              path: '/',
              pathType: 'Prefix',
              backend: {
                service: {
                  name: serviceName,
                  port: {
                    number: servicePort,
                  },
                },
              },
            },
          ],
        },
      }],
      tls: [{
        hosts: [
          host,
        ],
        secretName: '%s-tls' % name,
      }],
    },
  },
}
