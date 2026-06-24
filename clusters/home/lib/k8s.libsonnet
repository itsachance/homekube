{
  Namespace(name, labels={}):: {
    apiVersion: 'v1',
    kind: 'Namespace',
    metadata: {
      name: name,
      labels: { app: name } + labels,
    },

  },
  PV(name, storageSize, nfsPath, nfsServer):: {
    apiVersion: 'v1',
    kind: 'PersistentVolume',
    metadata: {
      name: name,
    },
    spec: {
      accessModes: [
        'ReadWriteMany',
      ],
      capacity: {
        storage: storageSize,
      },
      nfs: {
        path: nfsPath,
        server: nfsServer,
      },
      persistentVolumeReclaimPolicy: 'Retain',
      storageClassName: '',
    },
  },

  PVC(name, namespace, storageSize, volumeName):: {
    apiVersion: 'v1',
    kind: 'PersistentVolumeClaim',
    metadata: {
      name: name,
      namespace: namespace,
    },
    spec: {
      accessModes: [
        'ReadWriteMany',
      ],
      resources: {
        requests: {
          storage: storageSize,
        },
      },
      storageClassName: '',
      volumeName: volumeName,
    },
  },
}
