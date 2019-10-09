pipeline {
    environment{
        SCRIPT_NEXT_VERSION=""
        SCRIPT_TAG_SCM="no"
        FINISH_VERSION=""
    }
    agent {
        node {
            label 'registry'
        }
    }
    stages {
        stage('Git clone'){
            steps{
                git branch:"master" ,url: 'git@github.com:viavansi/viafirma-platform-example-java.git'
            }
        }
        stage ('Ask parameters'){
            steps{
                    script {
                        def currentVersion=
                            sh (
    script: 'mvn -q -Dexec.executable=echo -Dexec.args=\'${project.version}\' --non-recursive exec:exec',
    returnStdout: true
  ).trim()
                try
                {
                timeout(time: 30, unit: 'SECONDS'){

                        def INPUT_PARAMS=input message: 'Versioning?', ok: 'Next',
                        parameters: [ choice(name: 'NEXT_VERSION', choices: [currentVersion,
                                                                             'next incrementalVersion',
                                                                             'next minorVersion',
                                                                             'next majorVersion'].join('\n'), description: 'Please choose new version'),
                                      choice(name: 'TAG_SCM', choices: ['yes','no'], description: 'Tag and push')]
                        env.NEXT_VERSION=INPUT_PARAMS.NEXT_VERSION
                        env.TAG_SCM=INPUT_PARAMS.TAG_SCM
                        SCRIPT_NEXT_VERSION=INPUT_PARAMS.NEXT_VERSION
                        SCRIPT_TAG_SCM=INPUT_PARAMS.TAG_SCM
                    }

                }
                catch(err){
                    env.NEXT_VERSION=currentVersion
                    env.TAG_SCM='no'
                        SCRIPT_NEXT_VERSION=currentVersion
                        SCRIPT_TAG_SCM='no'
                }
                        }
               }
        }
        stage('Update incrementalVer'){
            when {
                expression {env.NEXT_VERSION=='next incrementalVersion'}
            }
            steps {
                echo "Change next incremental"
                sh "mvn build-helper:parse-version versions:set -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} versions:commit"
            }
        }
        stage('Update minorVersion'){
            when {
                expression {env.NEXT_VERSION=='next minorVersion'}
            }
            steps {
                echo "Change next minor"
                sh "mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.nextMinorVersion}.0 versions:commit"
            }
        }
         stage('Update majorVersion'){
            when {
                expression {env.NEXT_VERSION=='next majorVersion'}
            }
            steps {
                echo "Change next major"
                mvn "build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.nextMajorVersion}.0.0 versions:commit"
            }
        }

       // Launch compile and sonar
        stage('Build'){
            steps{
                withMaven(maven: 'maven-3.6.1') {
                    sh "mvn -U clean package -P tomcat6 sonar:sonar -Dsonar.host.url=${env.SONAR_SERVER} -Dmaven.test.skip=true"
                }
             }
        }
        stage('Push to git'){
            steps {
                sh "git add . || true"
                sh "git commit -a -m \"update version\" || true"
                sh "git push origin HEAD || head"
            }
        }

        stage('Tag git'){
           when {
                expression {SCRIPT_TAG_SCM=='yes'}
           }
           steps{
               script {
                        FINISH_VERSION=
                            sh (
    script: 'mvn -q -Dexec.executable=echo -Dexec.args=\'${project.version}\' --non-recursive exec:exec',
    returnStdout: true
  ).trim()
               }
               echo "${FINISH_VERSION}"
               sh "git tag --delete ${FINISH_VERSION}  || true"
               sh "git push --force origin :refs/tags/${FINISH_VERSION} || true"
               sh "git tag -a -f ${FINISH_VERSION} -m \"Update version:${FINISH_VERSION}\" || true"
               sh "git push --force origin ${FINISH_VERSION} || true"
           }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh "./build.sh"
                }
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: '**/*.war', onlyIfSuccessful: true, fingerprint: true
        }
    }
}
