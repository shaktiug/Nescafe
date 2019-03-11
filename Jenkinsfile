pipeline{
    agent any 
    environment {
        APP_NAME = 'Nescafe'
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
        GIT_URL="https://github.com/shaktiug/${APP_NAME}.git"
    }

    options {
        buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '20'))
        timestamps()
        //retry(3)
        timeout time:10, unit:'MINUTES'
    }
    parameters {
        string(defaultValue: "development", description: 'Branch Specifier', name: 'BRANCH')
        choice(name: 'config_type', choices: ['index.html', 'welcome.html'], description: 'Choose any one config to update')
		choice(name: 'instance', choices: ['dispatcher_1', 'dispatcher_2', 'All'], description: 'Choose the instance to deploy the config')
          }
          stages {

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
