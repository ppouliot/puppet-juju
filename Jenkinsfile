def SUFFIX = ''

pipeline {
    agent any

    parameters {
        string (name: 'VERSION_PREFIX', defaultValue: '0.0.0', description: 'puppet-juju version')
    }
    environment {
        BUILD_TAG = "${env.BUILD_TAG}".replaceAll('%2F','_')
        BRANCH = "${env.BRANCH_NAME}".replaceAll('/','_')
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '30'))
    }
    stages {
        stage ('Use the Puppet Development Kit Validation to Check for Linting Errors') {
            steps {
                sh 'pdk validate'
            }
        }
        stage ('Checkout and build puppet-juju in Docker to validate code as well as changes across OSes.') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' 
              }
            }
            steps {
                dir("${env.WORKSPACE}") {
                    sh './build.sh -d'
                }
            } 
        }
        stage ('Checkout and build puppet-juju in Vagrant to assemble a functional IPAM cluster') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' 
              }
            }
            steps {
                dir("${env.WORKSPACE}") {

                    sh './build.sh -v'
                }
            } 
        }
        
        stage ('Cleanup vagrant after successful build.') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' 
              }
            }
            steps {
                sh 'vagrant destroy -f'
            }
        }

    } 
}
