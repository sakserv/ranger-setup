#!/usr/bin/env bash

# Source the config
. /tmp/ranger-setup/conf/env.cfg

# Install the JDBC driver on all agent nodes
for node in $(echo $AGENT_NODE_LIST | tr ',' ' '); do
    echo -e "\n#### Checking for the $SQL_TYPE JDBC driver on $node"
    if ! ssh $SSH_ARGS $node "test -f $SQL_JDBC_DRIVER_PATH"; then
        ssh $SSH_ARGS $node "yum install $SQL_JDBC_PACKAGE_NAME -y"
    fi
done

# Configure Ambari JDBC driver
echo -e "\n####  Registering the JDBC driver with Ambari"
ssh $SSH_ARGS $AMBARI_NODE "/usr/sbin/ambari-server setup --jdbc-db=$SQL_TYPE --jdbc-driver=$SQL_JDBC_DRIVER_PATH"

echo -e "\n####  Install and start package $SQL_SERVER_PACKAGE_NAME on $SQL_NODE"
ssh $SSH_ARGS $SQL_NODE "yum install $SQL_SERVER_PACKAGE_NAME -y"
ssh $SSH_ARGS $SQL_NODE "service $SQL_SERVER_SERVICE_NAME start"

echo -e "\n####  Running grants for Ranger on $SQL_NODE"
scp $SSH_ARGS $SQL_GRANT_SCRIPT $SQL_NODE:/tmp/
ssh $SSH_ARGS $SQL_NODE "mysql -uroot -h localhost </tmp/$(echo $SQL_GRANT_SCRIPT | awk -F\/ '{print $NF}')"

echo -e "\n####  Restarting ambari-server and ambari-agent"
ssh $SSH_ARGS $AMBARI_NODE "service ambari-server restart"
ssh $SSH_ARGS $AMBARI_NODE "service ambari-agent restart"

echo -e "\n####  SUCCESS! Proceed to Ambari Web and add the Ranger service"
