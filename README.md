Ranger Setup
-------------------------

Performs the presteps necessary for setting up Apache Ranger with Ambari 2.0


Prereq
------

* Passphraseless SSH as root
* Ambari 2.0

Usage
-----

The following outlines how to use this project.

* Clone the repo:
```
cd /tmp && git clone https://github.com/sakserv/ranger-setup.git
```

* Modify the config:
```
cd /tmp/ranger-setup && vi conf/env.cfg
```

* Run the Ranger setup script
```
cd /tmp/ranger-setup && bash -x bin/setup.sh
```
