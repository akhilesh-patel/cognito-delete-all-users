# cognito-delete-all-users
cognito-delete-all-user-with help of script file 
#NOTE: only chnage pool id in this file.

step1: aws configure 

step2: delete-all-user.sh // put the permission for this file  "chmod -R 777 delete-all-user.sh"

step3: run file ./delete-all-user.sh

step4: output deleted your all user one by one 

########################################################################################################

#!/bin/bash

read -p  "Are you realy want to  delete all user(yes/no):" yn

case $yn in 

	yes) echo ok , we will proceed;;
	
	no ) echo exiting ..;
	
	     exit;;
	     

	*) echo invalid response;
	
	   exit 1;;
	   
esac


echo doing stuff...


USER_POOL_ID="enter your user pool id"


RUN=1

until [ $RUN -eq 0 ] ; do

echo "Listing users"

USERS=`aws cognito-idp list-users --user-pool-id ${USER_POOL_ID} | grep Username | awk -F: '{print $2}' | sed -e 's/\"//g' | sed -e 's/,//g'`

if [ ! "x$USERS" = "x" ] ; then

	for user in $USERS; do
	
		echo "Deleting user $user"
		
		aws cognito-idp admin-delete-user --user-pool-id ${USER_POOL_ID} --username ${user}
		
		echo "Result code: $?"
		
		echo "Done"
		
	done
	
else

	echo "Done, no more users"
	
	RUN=0
	
fi

done





