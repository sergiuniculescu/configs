#!/usr/bin/python

import os
 
#Enter your domain, username and password below within double quotes
# eg. domain="yourdomain.com", username="username" and password="password"
domain="gmail.com"
username="contact.sergiuniculescu"
password="Cacatecucu!100180"
com="wget -q -O - https://mail.google.com/a/"+domain+"/feed/atom --http-user="+username+"@"+domain+" --http-password="+password+" --no-check-certificate"

temp=os.popen(com)
msg=temp.read()
index=msg.find("<fullcount>")
index2=msg.find("</fullcount>")
fc=int(msg[index+11:index2])

if fc==0:
   print ("no new messages")
else:
   print (str(fc)+" new")
