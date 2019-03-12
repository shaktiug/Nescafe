set -x
#if [ "${instance}" =  "dispatcher_1" ];
#then
if  [ "${config_type}" = "index.html" ] || [ "${config_type}" = "welcome.html" ];
then
echo " Backing up the deployed ${config_type} "
if [ -f /var/www/html/${config_type} ];
then
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.24.159.153 "sudo cp /var/www/html/${config_type} /var/www/html/${config_type}.bak"
fi
echo " Deploying the new ${config_type} "

scp -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ${WORKSPACE}/${config_type} ec2-user@52.24.159.153:/tmp
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.24.159.153 "sudo mv /tmp/${config_type} /var/www/html/${config_type}"
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.24.159.153 "sudo chown root:root /var/www/html/${config_type}; sudo chmod 644 /var/www/html/${config_type}"

echo " Restarting dispatcher 1 "
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@52.24.159.153 "sudo service httpd restart"
fi
#fi

#if [ "${instance}" =  "dispatcher_2" ];
#then
if  [ "${config_type}" = "index.html" ] || [ "${config_type}" = "welcome.html" ];
then
echo " Backing up the deployed ${config_type} "
if [ -f /var/www/html/${config_type} ];
then
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@35.165.153.83 "sudo cp /var/www/html/${config_type} /var/www/html/${config_type}.bak"
fi
echo " Deploying the new ${config_type} "

scp -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ${WORKSPACE}/${config_type} ec2-user@35.165.153.83:/tmp
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@35.165.153.83 "sudo mv /tmp/${config_type} /var/www/html/${config_type}"
ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@35.165.153.83 "sudo chown root:root /var/www/html/${config_type}; sudo chmod 644 /var/www/html/${config_type}"

echo " Restarting dispatcher 1 "

ssh -i /var/lib/jenkins/dev-aws.pem -o StrictHostKeyChecking=no ec2-user@35.165.153.83 "sudo service httpd restart"
fi
#fi
set +x