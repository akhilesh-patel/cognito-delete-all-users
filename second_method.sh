#!/bin/bash
COGNITO_USER_POOL_ID="Enter you  User Pool Id"
aws cognito-idp list-users --user-pool-id $COGNITO_USER_POOL_ID |
jq -r '.Users | .[] | .Username' |
while read user; do
        aws cognito-idp admin-delete-user --user-pool-id $COGNITO_USER_POOL_ID --username $user
        echo "$user deleted"
done

#Install jq
#sudo apt update
#sudo apt install -y jq
