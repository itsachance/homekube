{
  HelmRepository(name, url, type=''):: {
    apiVersion: 'source.toolkit.fluxcd.io/v1',
    kind: 'HelmRepository',
    metadata: {
      name: name,
      namespace: 'flux-system',
    },
    spec: {
      interval: '24h',
      url: url,
    } + (if type != '' then {
           type: type,
         } else {}),
  },

  HelmRelease(name, namespace, chart, version, repoName, values={}, createNamespace=true):: {
    apiVersion: 'helm.toolkit.fluxcd.io/v2',
    kind: 'HelmRelease',
    metadata: {
      name: name,
      namespace: namespace,
    },
    spec: {
      interval: '30m',
      chart: {
        spec: {
          chart: chart,
          version: version,
          sourceRef: {
            kind: 'HelmRepository',
            name: repoName,
            namespace: 'flux-system',
          },
        },
      },
      install: {
        createNamespace: createNamespace,
      },
      values: values,
    },
  },
}
