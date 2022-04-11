node("maorsslave"){
    dir("${env.BUILD_NUMBER}"){
        stage("git clone"){
             sh "git clone https://github.com/maormalca/count_python_withterraform.git"   
        }
        stage("build"){
            sh "docker-compose up -d"
        }
        stage("test"){
            def test = sh(returnStdout: true, script: 'curl localhost:8081/query &> /dev/null && echo $?').trim() 
            if (test != '0' ){
                error("Build failed webserver is down..")
            }
            else{
                println("the web server is up")
            }
        }
   }   
}
