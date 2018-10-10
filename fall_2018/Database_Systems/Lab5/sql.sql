-- insert into employee from txt file
load data local infile '~/Downloads/employee.txt' replace into table employee FIELDS TERMINATED BY '        ' ENCLOSED BY '' ESCAPED BY '\\' LINES TERMINATED BY '\n' STARTING BY '' (Fname, Minit, Lname, Ssn, Bdate, Address, sex, salary, supervisor, department);
