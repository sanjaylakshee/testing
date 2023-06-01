node{ 
 stage("SCM Checkout"){
 git url: 'https://github.com/sanjaylakshee/java-web-app-docker.git',branch: 'master'
 }
 
  stage("Mavenclean"){
 def mavenHome = tool name: "Maven-3", type: "maven"
 def mavenCMD = "${mavenHome}/bin/mvn"
 sh "${mavenCMD} clean package"
 }
 
 
  stage("terraform"){
 sshagent(['dockerHubApp']) {
 sh "ssh -o StrictHostKeyChecking=no ec2-user@54.197.141.95 terraform init"
 sh "ssh -o StrictHostKeyChecking=no ec2-user@54.197.141.95 terraform apply --auto-approve"
 }
 }
 
}