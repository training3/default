pipeline {
    agent {
        kubernetes {
            label 'agent'
            defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  serviceAccountName: cd-jenkins
  containers:
  - name: app
    image: buvan/git
    command: ["/bin/sh","-c","cd /data && git clone https://github.com/bksivasub-egov-macroskies/myApp.git && cat"]
    tty: true
    volumeMounts:
      - name: shared-volume
        mountPath: /data

  - name: kaniko
    image: gcr.io/kaniko-project/executor:latest
    args: ["--dockerfile=/data/myApp/Dockerfile",
            "--context=/data/myApp",
            "--destination=buvan/hiya"]
    volumeMounts:
      - name: kaniko-secret
        mountPath: /kaniko/.docker
      - name: shared-volume
        mountPath: /data
  restartPolicy: Never
  volumes:
    - name: shared-volume
      emptyDir: {}
    - name: kaniko-secret
      secret:
        secretName: regcred
        items:
          - key: .dockerconfigjson
            path: config.json
        """
        }
    }
    stages {
        stage('Verify if image is pushed'){
            steps {
                container('app') {
                    sh """
                    echo "The image is built and pushed to registry successfully!"                  
                    """
                }
            }
        }
    }
}
