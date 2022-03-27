@Library('pipeline_environment')_
pipeline {
  agent any
  environment {
    SONAR_PROJECTKEY= 'amis-ocra_gft_amis-ocra-bitacoras'
    SONAR_INSTALLATION_NAME = 'SonarQube'
    ENVIRONMENT = getDeploymentEnv(env.BRANCH_NAME)
    GCP=''
    GCP_PROJECT_ID = 'amis-ocra-dev'
  }

  options {
    buildDiscarder(
      logRotator(
          numToKeepStr: '5',
          artifactNumToKeepStr: '5'
      )
    )
  }

  stages {
    stage('Environment') {
      steps {
        script{
            def varName = "GCP_SISTEMA_DATA_${ENVIRONMENT}"
            //GCP =getMap(env[varName])
        }
      }
    }

    stage('Init') {
      steps {
        sh 'docker run \
            -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
            --rm \
            -w $(pwd) \
            -v /etc/group:/etc/group:ro \
            -v /etc/passwd:/etc/passwd:ro \
            -v $(pwd):$(pwd) \
            -v ${HOME}/.gcp:${HOME}/.gcp \
            hashicorp/terraform:0.12.26 \
            init'
      }
    }

    stage('Plan') {
      steps {
        sh 'docker run \
            -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
            --rm \
            -w $(pwd) \
            -v /etc/group:/etc/group:ro \
            -v /etc/passwd:/etc/passwd:ro \
            -v $(pwd):$(pwd) \
            -v ${HOME}/.gcp:${HOME}/.gcp \
            hashicorp/terraform:0.12.26 \
            plan'
      }
    }

    stage('Apply') {
      steps {
        sh 'docker run \
            -u $(id -u):$(grep -w docker /etc/group | awk -F\: '{print $3}') \
            --rm \
            -w $(pwd) \
            -v /etc/group:/etc/group:ro \
            -v /etc/passwd:/etc/passwd:ro \
            -v $(pwd):$(pwd) \
            -v ${HOME}/.gcp:${HOME}/.gcp \
            hashicorp/terraform:0.12.26 \
            apply'
      }
    }

    stage('End') {
      steps {
        echo 'End of pipeline'
      }
    }
  }
}