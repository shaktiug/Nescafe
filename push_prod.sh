
if [ "${instance}" =  "dispatcher_1" ];
then
if  [ "${config_type}" = "index.html" ] || [ "${config_type}" = "welcome.html" ];
then
echo " Backing up the deployed ${config_type} "
if [ -f /var/www/html/${config_type} ];
then
ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.222.1.157 "sudo cp /var/www/html/${config_type} /var/www/html/${config_type}.bak"
fi
echo " Deploying the new ${config_type} "

scp -i /var/lib/jenkins/dev-aws.pem ${WORKSPACE}/${config_type} ec2-user@34.222.1.157:/tmp
ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.222.1.157 "sudo mv /tmp/${config_type} /var/www/html/${config_type}"
ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.222.1.157 "sudo chown root:root /var/www/html/${config_type}; sudo chmod 644 /var/www/html/${config_type}"

echo " Restarting dispatcher 1 "

ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.222.1.157 "sudo service httpd restart"

if [ "${instance}" =  "dispatcher_2" ];
then
if  [ "${config_type}" = "index.html" ] || [ "${config_type}" = "welcome.html" ];
then
echo " Backing up the deployed ${config_type} "
if [ -f /var/www/html/${config_type} ];
then
ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.212.29.187 "sudo cp /var/www/html/${config_type} /var/www/html/${config_type}.bak"
fi
echo " Deploying the new ${config_type} "

scp -i /var/lib/jenkins/dev-aws.pem ${WORKSPACE}/${config_type} ec2-user@34.212.29.187:/tmp
ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.212.29.187 "sudo mv /tmp/${config_type} /var/www/html/${config_type}"
ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.212.29.187 "sudo chown root:root /var/www/html/${config_type}; sudo chmod 644 /var/www/html/${config_type}"

echo " Restarting dispatcher 1 "

ssh -i /var/lib/jenkins/dev-aws.pem ec2-user@34.212.29.187 "sudo service httpd restart"