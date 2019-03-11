pipeline{
    agent {
       docker {
         image: 'httpd:latest'
         args '-p 80:80 -v /var/www/html:/var/www/html'
       }
    environment {
        APP_NAME = 'Nescafe'
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
        GIT_URL="git@github.yourdomain.com:shaktiug/${APP_NAME}.git"
    }

    options {
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '20'))
        timestamps()
        //retry(3)
        timeout time:10, unit:'MINUTES'
    }
    parameters {
        string(defaultValue: "development", description: 'Branch Specifier', name: 'BRANCH')
        choice(name: 'dispatcher config', choices: ['vhost.nescafe.conf', 'vhost.nescafe-market.conf'], description: 'Choose any one config to update')
		choice(name: 'instances', choices: ['dispatcher 1', 'dispatcher 2', 'All'], description: 'Choose the instance to deploy the config')
          }
          stages {
          stage("Initialize") {
              steps {
                  script {
                      notifyBuild('STARTED')
                      echo "${BUILD_NUMBER} - ${env.BUILD_ID} on ${env.JENKINS_URL}"
                      echo "Branch Specifier :: ${params.SPECIFIER}"
                  }
              }
          }

          stage('Checkout') {
              steps {
                  echo 'Checkout Repo'
                  git branch: "${params.BRANCH}", url: "${GIT_URL}"
              }
      }

          stage('Test') {
              steps {
                  echo 'Testing the configuration'
                  sh 'httpd -v'
				  returnStdout: true
              }
}
          stage('Deploy to UAT') {
                  steps {
                      echo 'Pushing the config to the webservers'
                      sh './push_uat.sh'
                  }
          }
          stage('Sanity check') {
            steps {
                input "Does the staging environment look ok?"
            }
        }

        stage('Deploy to PROD') {
                steps {
                    echo 'Pushing the config to the webservers'
                    sh './push_prod.sh'
                }
        }

}
}
}
