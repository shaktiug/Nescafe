set -x
if [ "${instance}" =  "dispatcher_uat" ];
then
if  [ "${config_type}" = "index.html" ] || [ "${config_type}" = "welcome.html" ];
then
echo " Backing up the deployed ${config_type} "
if [ -f /var/www/html/${config_type} ];
then
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.12.160.247 "sudo cp /var/www/html/${config_type} /var/www/html/${config_type}.bak"
fi
echo " Deploying the new ${config_type} "

scp -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ${WORKSPACE}/${config_type} ec2-user@52.12.160.247:/tmp
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.12.160.247 "sudo mv /tmp/${config_type} /var/www/html/${config_type}"
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.12.160.247 "sudo chown root:root /var/www/html/${config_type}; sudo chmod 644 /var/www/html/${config_type}"

echo " Restarting dispatcher 1 "

ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.12.160.247 "sudo service httpd restart"
fi
fi

set +x