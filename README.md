# chef-workshops

## Basics
The cookbooks in this repo will install Tomcat v8.5 and MongoDB v3.4 on Centos v7.

I created the cookbooks with ChefDK v0.6.2 and used my hosted Chef account for chef-client convergence. 

## Details

The MongoDB cookbook is a simple installation. I created a template for the MongoDB yum repo, installed MongoDB, and set mongod to start on boot. 

The Tomcat cookbook is a bit more sophisticated in that I used attribute variables.  
