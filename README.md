# Continuous Code inspection with SonarQube
![Continuous Code inspection with SonarQube](https://github.com/WhiteLord/sonar-jenkins/blob/master/Continuous-code-inspection-with-sonarqube.png?raw=true)

## What is this repository?
This repository covers the [Continuous Code inspection with SonarQube](https://www.udemy.com/course/continuous-code-inspection-with-sonarqube) course content.

Instructor:[WhiteLord](https://github.com/WhiteLord)

## How do I use the repository?
To make use of all the features of this repository, please use the **main** branch.
All other branches (may be) contain older version of Angular, thus containing dependencies which are either abandonware or contain vulnerabilities.

`git clone` the repository to a prefered location on your machine.

```
git clone https://github.com/ElipLam/SonarQube-Jenkins
cd SonarQube-Jenkins
```

## Get started

Run all containers:

```
docker compose up -d --build
```
### Jenkins

Get jenkins initial password:

```
docker exec -it jenkins sh -c 'cat  $(find / -name initialAdminPassword)'
```

Output sample: ```373f************************9f21```

Login jenkins server: http://localhost:8080

After login jenkins, copy Sonar Analysis-Code to container:

```
docker cp Sonar-Analysis-Code jenkins:/var/jenkins_home/jobs/Sonar-Analysis-Code
docker compose restart jenkins
```

### Sonarqube

Login SonarQube server: http://localhost:9000

Default user:

- username: admin
- password: admin

Note: if you want easy exercise, please change password to `4^F@)x.;Nrb(S&]`

## How do I generate unit test coverage data? 

### Syntax

Java test coverage reports are generated with: 

``` 
mvn org.jacoco:jacoco-maven-plugin:prepare-agent verify org.jacoco:jacoco-maven-plugin:report sonar:sonar -Dsonar.jdbc.username=<POSTGRES_USER> -Dsonar.jdbc.password=<POSTGRES_PASSWORD> -Dsonar.host.url=http://<sonarqube-address>:9000 -Dsonar.jdbc.url=jdbc:postgresql://<postgre-address>/sonarqube -Dsonar.login=<your-sonar-user> -Dsonar.password=<your-sonar-password>
```

Angular test coverage reports are generated from frontend-client folder with:

``` 
mvn clean install -Dsonar-scan sonar:sonar Dsonar.jdbc.username=<POSTGRES_USER> -Dsonar.jdbc.password=<POSTGRES_PASSWORD> -Dsonar.host.url=http://<sonarqube-address>:9000 -Dsonar.jdbc.url=jdbc:postgresql://<postgre-address>/sonarqube -Dsonar.login=<your-sonar-user> -Dsonar.password=<your-sonar-password> 
```

### Manually:

Java test coverage reports are generated with: 

```
mvn org.jacoco:jacoco-maven-plugin:prepare-agent verify org.jacoco:jacoco-maven-plugin:report
```

See the result in: `{project.basedir}/target/site/jacoco/index.html`

Angular test coverage reports are generated with:

```
cd frontend/frontend-client 
mvn clean install -Dsonar-scan -Dsonar.login=admin -Dsonar.password=<your-sonar-password>
```

### Report to SonarQube

Declare environment variables:

```
mvn --version
mvn clean package

export IP=192.168.1.94 #change me
export SONAR_PASS="4^F@)x.;Nrb(S&]" #change me
```

Java test coverage reports are generated with: 

```
mvn org.jacoco:jacoco-maven-plugin:prepare-agent verify org.jacoco:jacoco-maven-plugin:report sonar:sonar -Dsonar.jdbc.username=sonar -Dsonar.jdbc.password=sonar -Dsonar.host.url=http://$IP:9000 -Dsonar.jdbc.url=jdbc:postgresql://$IP/sonarqube -Dsonar.login=admin -Dsonar.password=$SONAR_PASS
```

Angular test coverage reports are generated with:

```
cd frontend/frontend-client

mvn clean install -Dsonar-scan sonar:sonar -Dsonar.jdbc.username=sonar -Dsonar.jdbc.password=sonar -Dsonar.host.url=http://$IP:9000 -Dsonar.jdbc.url=jdbc:postgresql://$IP/sonarqube -Dsonar.login=admin -Dsonar.password=$SONAR_PASS
```

### Automation

Access Sonar Analysis project: http://localhost:8080/job/Sonar-Analysis-Code/

Click "Configure" button and scoll down to update your IP and Sonar password.

Click "Build Now" button to run pipeline.

Then watch the reports at this link: http://localhost:9000/projects

## Tips
change java version:

```
sudo update-alternatives --config java
```
