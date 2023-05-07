# AirbnbCase-Dina
# Airbnb datamart project

MySQL database of a Airbnb system 

<img width="705" alt="Screenshot 2023-05-07 at 8 12 07 PM" src="https://user-images.githubusercontent.com/85529608/236696244-9d329ee4-fe23-4093-bd29-ecfdc267f1e8.png">




## Schema details

In the following picture, the details of the schema have been shown. Using the “SHOW TABLE STATUS FROM db” query, I extract the schema information in a .csv file which is available in the finalization directory.

<img width="1347" alt="Screenshot 2023-05-07 at 8 40 16 PM" src="https://user-images.githubusercontent.com/85529608/236696295-6510a947-5426-4cbc-b4be-7fdd15f2af3b.png">



## Installation

It is first necessary to install MySQL on your system. Afterward, the data mart can be used with any MySQL database system. I suggest the MySQL Workbench community version, a free DBMS, that can also open the model file, which is a .mwb file located in the development directory.
MySQL can be installed from Here
MySQL Workbench can be installed from Here
After creating a database connection and a schema, using the data import tool in the server tab, you can import the mydb.sql file, which is in the finalization directory.
