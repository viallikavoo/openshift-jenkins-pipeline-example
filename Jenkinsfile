pipeline {
  agent {
        node {label 'master'}
    }
    environment {
        APPLICATION_NAME = 'example-pipeline'
        TEST_PROJECT = "project1"
        SERVICE_TEMPLATE_PATH =  "openshift/templates/serviceConfig.yaml"
        BUILD_TEMPLATE_PATH = "openshift/templates/buildConfig.yaml"
        SERVICE_PARAMETERS_PATH = "openshift/parameters/test/params-service-test.env"
        BUILD_PARAMETERS_PATH = "openshift/parameters/test/params-build-test.env"
        //PORT = 8081;
    }
    stages {

				stage('create') {
					steps {
						script {
								openshift.withCluster("TEST-CLUSTER") {
                  sh """cat openshift/templates/serviceConfig.yaml"""
                      def temp = openshift.process("-f",SERVICE_TEMPLATE_PATH,"--param-file=${SERVICE_PARAMETERS_PATH}")
                      println temp
                      openshift.apply(temp)
								}
						}
					}
				}
        stage('Build Image') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject("TEST-CLUSTER") {
                            def temp = openshift.process("-f",BUILD_TEMPLATE_PATH,"--param-file=${BUILD_PARAMETERS_PATH}")
                            openshift.apply(temp)
                            openshift.selector("bc", "$APPLICATION_NAME").startBuild("--from-dir=.", "--wait=true", "--follow")
                        }
                    }
                }
            }
        }
    }
}
