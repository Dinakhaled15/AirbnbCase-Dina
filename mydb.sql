CREATE SCHEMA IF NOT EXISTS `myDB` DEFAULT CHARACTER SET utf8 ;
USE `myDB` ;

CREATE TABLE customers (

id INT NOT NULL,
 first_name VARCHAR (50) NOT NULL, 
last_name VARCHAR (50) NOT NULL, 
gender VARCHAR (10) NOT NULL, 
age INT NOT NULL,
 job_title VARCHAR (50) NOT NULL, 
dependents_id INT NOT NULL, 
address_id INT NOT NULL, 
staff_id INT NOT NULL, 
login_id INT NOT NULL, 
reservation_id INT NOT NULL, 
PRIMARY KEY (id),
FOREIGN KEY (dependents_id) REFERENCES dependents (id),
FOREIGN KEY (address_id) REFERENCES room_address (id),
FOREIGN KEY (staff_id) REFERENCES staff (id),
FOREIGN KEY (login_id) REFERENCES login (id),
FOREIGN KEY (reservation_id) REFERENCES reservations (id)
);
DESC customers;

INSERT INTO customers (id, first_name, last_name, gender, age, job_titles, job_industry, dependents_id, address_id, staff_id,login_id,reservation_id)
VALUES
(1, 'John','Doe','Male', 35,'Software Engineer', 'IT', 1, 1, 1, 1, 1),
(2, 'Jane', 'Doe', 'Female', 28,'Accountant', 'Finance', 2, 2, 2, 2, 2),
(3,'Bob', 'Smith', 'Male', 45, 'Doctor' , 'Healthcare', 3, 3, 3, 3, 3),
(4, 'Alice', 'Jones', 'Female', 52,'Lawyer','Legal', 4, 4, 4, 4, 4),
(5,'Mike','Williams','Male', 27, 'Marketing Manager','Marketing', 5, 5, 5, 5, 5),
(6,'Susan', 'Lee', 'Female', 31,'Graphic Designer', 'Advertising', 6, 6, 6, 6, 6),
(7,'David', 'Wilson', 'Male', 39,'Project Manager', 'Construction', 7, 7, 7, 7, 7),
(8,'Mary','Brown', 'Female', 48,'Nurse''Healthcare', 8,8, 8, 8, 8),
(9, 'Peter', 'Taylor', 'Male', 25, 'Sales Representative', 'Retail', 9, 9, 9, 9, 9),
 (10, 'Karen' , 'Miller', 'Female', 37, 'Human Resources Manager', 'HR', 10, 10, 10, 10, 10),
(11,'Tom', 'Johnson', 'Male', 42, 'Architect', 'Construction', 11, 11, 11, 11, 11), 
(12, 'Laura','Garcia', 'Female', 29, 'Web Developer', 'IT', 12, 12, 12, 12, 12),
(13, 'Chris''Jackson', 'Male', 33, 'Financial Analyst', 'Finance', 13, 13, 13, 13, 13),
(14, 'Karen', 'Miller', 'Female', 37, 'Human Resources Manager', 'HR', 14, 14, 14, 14, 14), 
(15, 'Mark', 'Davis', 'Male', 50, 'CEO', 'Management', 15, 15, 15, 15, 15), 
(16, 'Olivia', 'Johnson', 'Female', 32, 'Product Manager', 'IT', 16, 16, 16, 16, 16), 
(17, 'Adam' , 'Gomez', 'Male', 26, 'Software Developer', 'IT', 17, 17, 17, 17, 17), 
(18, 'Emma', 'Hernandez', 'Female', 43, 'Marketing Coordinator', 'Marketing', 18, 18, 18, 18, 18),
(19, 'Jason', 'Allen', 'Male', 38, 'Financial Planner', 'Finance', 19, 19, 19, 19, 19), 
(20, 'Sophia', 'Nguyen', 'Female', 27, 'UX Designer',  'Advertising', 20, 20, 20, 20, 20);

SELECT 
    c.customer_id,
    c.first_name, 
    c.last_name, 
    a.house_number, 
    a.street, 
    a.postcode, 
    a.id, 
    d.spouse, 
    d.pets
FROM 
    customers c 
JOIN 
    address a ON c.house_number = a.house_number 
LEFT JOIN 
    dependents d ON c.customer_id = d.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name;

CREATE TABLE dependents (
id INT PRIMARY KEY, 
spouse INT,
 children INT, 
 infants INT, 
 pets INT, 
 last_updated DATE
);
DESC dependents;
INSERT INTO dependents (id, spouse, children, infants, pets, last_updated)
 VALUES
(1, 1, 2, 1, 0, '2023-04-08'),
(2, 0, 3, 0, 1,'2023-04-08'),
(3, 1, 1, 0, 2,"2023-04-08'),
(4, 1, 0,0, 0,'2023-04-08'),
(5, 0, 0,1,0,1 '2023-04-08'),
(6, 0, 2, 0, 0, '2023-04-08'),
(7, 1, 1, 0, 1,'2023-04-08'),
(8, 0, 1, 1, 0, '2023-04-08"),
(9, 0, 3, 0, 2,'2023-04-08'),
(10, 1, 2, 2, 3,'2023-04-08'),
(11, 0, 0, 0, 1, '2023-04-08'),
(12, 1, 1, 1, 0,'2023-04-08'),
(13, 0, 2, 0, 2,'2023-04-08'),
(14, 1, 3, 0, 0,'2023-04-08'),
(15, 1, 1, 0, 1,'2023-04-08'),
(16, 0, 0, 1, 1, '2023-04-08'),
(17, 1, 2, 1, 2,'2023-04-08'),
(18, 1, 1, 0, 0, '2023-04-08'),
(19, 0, 1, 0, 0,'2023-04-08'),
(20, 0, 0, 0, 2, '2023-04-08');

SELECT 
    s.staff_id,
    s.first_name, 
    s.last_name, 
    s.gender, 
    l.email, 
    l.last_login_date, 
    COUNT(DISTINCT d.dependent_id) AS num_dependents
FROM 
    staff s 
JOIN 
    login l ON s.login_id = l.login_id 
LEFT JOIN 
    dependents d ON s.staff_id = d.staff_id
GROUP BY 
    s.staff_id, s.first_name, s.last_name, s.gender, l.email, l.last_login_date;



CREATE TABLE staff (
id INT PRIMARY KEY, 
first_name VARCHAR (50) , 
last_name VARCHAR (50) ,
 gender CHAR(1), position VARCHAR (50), 
 post_inspection_id INT
);
DESC staff;

INSERT INTO staff (id, first_name, last_name, gender, position, post_inspection_id)
 VALUES 
(1, 'John','Doe','M','Manager', 100),
(2,'Jane','Smith', 'F', 'Supervisor', 101),
(3,'Mike','Johnson''M', 'Associate', 102),
(4,'Sara','Williams','Manager', 103),
(5,'Tom', 'Brown','M','Supervisor', 104),
(6,'Emily','Davis','F','Associate', 105),
(7, 'David','Wilson','M','Manager', 106),
(8,'Megan','Martin','F','Supervisor', 107),
(9,'Adam','Thompson','M','Associate', 108),
(10,'Olivia','Clark','F','Manager', 109),
(11,'Chris','Lee', 'M','Supervisor', 110),
(12,'Amanda','Garcia','F','Associate', 111),
(13,'Brian','Rodriguez','M', 'Manager', 112),
(14,'Sophia','Lopez','F','Supervisor', 113),
(15,'Eric', 'Perez','M','Associate', 114),
(16,'Ashley','Gonzalez','F','Manager', 115),
(17, 'Josh', 'Hernandez','M','Supervisor', 116),
(18,'Victoria', 'Wilson','F','Associate', 117),
(19,'Alex','King','M','Manager', 118),
(20,'Grace','Nelson','Supervisor', 119);

SELECT 
    s.staff_id,
    s.first_name, 
    s.last_name, 
    COUNT(DISTINCT pi.inspection_id) AS num_inspections,
    COUNT(DISTINCT d.dependent_id) AS num_dependents
FROM 
    staff s 
LEFT JOIN 
    post_inspection pi ON s.staff_id = pi.staff_id
LEFT JOIN 
    dependents d ON s.staff_id = d.staff_id
GROUP BY 
    s.staff_id, s.first_name, s.last_name;


CREATE TABLE post_inspection (
id INT PRIMARY KEY,
amenities VARCHAR (50),
facilities VARCHAR (50),
entertainment VARCHAR (50)
);
DESC post_inspection;

INSERT INTO post_inspection (id, amenities, facilities, entertainment) 
VALUES
(100,'Swimming pool, fitness center, restaurant','Conference room, parking lot', 'Movie theater'),
(101,'Tennis court, spa, bar','Business center, valet parking', 'Karaoke room'),
(102,'Gym, sauna, coffee shop','Laundry room, shuttle service','Game room'),
(103,'Outdoor pool, restaurant, gift shop','Banquet hall, covered parking','Live music venue'),
(104, 'Basketball court, poolside bar','24-hour front desk, baggage storage', 'Billiards room'),
(105, 'Indoor pool, cafe, lounge', 'AM, car rental', 'Bowling alley'),
(106,'Beach access, BBQ area', 'Meeting room, luggage storage', 'Nightclub'),
(107, 'Golf course, restaurant, convenience store', 'Gift shop, bicycle rental', 'Arcade room'),
(108, 'Hiking trail, coffee bar','Library, pet-friendly', 'Mini theater'),
(109, 'Diving center, beach club, pool', 'Elevator, parking garage', 'Discotheque'),
(110,'Spa, juice bar, lounge','Concierge, currency exchange', 'Table tennis'),
(111,'Jacuzzi, cafe, gift shop', 'Dry cleaning, grocery delivery', 'Video game room'),
(112,'Ski slope, restaurant, bar','Ski storage, snowboard rentals','Karaoke bar'),
(113,'Beachfront, restaurant, pool','Free Wi-Fi, luggage storage','Live entertainment'),
(114,'Water park, restaurant, sauna','Babysitting service, airport shuttle','Foosball table'),
(115,'Indoor pool, cafe, bar','Room service, concierge desk', 'Movie room'),
(116,'Park, basketball court, BBQ area','24-hour security, parking lot','Ping pong table'),
(117, 'Beach, fitness center, restaurant', 'Free parking, meeting room','Disco room'),
(118,'Sky lounge, restaurant, bar', 'Fitness room, laundry facilities','Private cinema'),
(119, 'Pool, restaurant, spa','Business center, shuttle service', 'Video game arcade');

SELECT 
    s.staff_id,
    s.first_name, 
    s.last_name, 
    COUNT(DISTINCT pi.inspection_id) AS num_inspections,
    AVG(pi.rating) AS avg_rating,
    SUM(pi.facilities) AS total_facilities,
    SUM(pi.entertainment) AS total_entertainment
FROM 
    post_inspection pi
JOIN 
    staff s ON pi.staff_id = s.staff_id
GROUP BY 
    s.staff_id, s.first_name, s.last_name;


CREATE TABLE address ( 
id INT PRIMARY KEY, 
house_no VARCHAR (50), 
street VARCHAR (50) , 
post_code VARCHAR (50), 
last_updated DATE, 
city_id INT
);
DESC address;
INSERT INTO address (id, house_no, street, post_code, last_updated, city_id) VALUES
(100,'123', 'Main Street', 'ABC123','2022-01-01', 1),
(101,'456','Elm Street','DEF456','2022-01-01', 2),
(102,'789','Oak Street',' GHI789','2022-01-01', 3),
(103,'1321','Pine Street',' JKL321','12022-01-01', 4),
(104,'6541','Maple Street','12922-01-01', 5),
(105,'19871','Cedar Street','POR987', '2022-01-01', 1),
(106,'159', 'Birch Street','STU159', '2022-01-01', 2),
(107,'17531','Spruce Street','VWX753','2022-01-01', 3),
(108,'1246','Walnut Street', 'YZA246','2022-01-01', 4),
(109,'1864','Fir Street', 'BCD864','2022-01-01', 5),
(110,'12221','Chestnut Street','EFG222', '2022-01-01', 1),
(111,'444','Poplar Street', 'HIJ444','2022-01-01', 2),
(112,'666','Sycamore Street', 'KLM666', '2022-01-01', 3),
(113,'18881','Ash Street', 'NOP888','2022-01-01', 4),
(114,'11111','Willow Street','QRS111', '2022-01-01', 5),
(115,'13331','Hickory Street','TUV3334', '2022-01-01', 1),
(116,'1555','Beech Street','WXY555','12022-01-01', 2),
(117,'17771','Juniper Street','ZAB777','2022-01-01', 3),
(118, '999','Dogwood Street','CDE999','2022-01-01', 4),
(119,'121','Mulberry Street','UFGH1211','2022-01-01',5);


CREATE TABLE city2 
( city_id INT PRIMARY KEY,
 name_city VARCHAR (50) NOT NULL, 
 state VARCHAR (50) NOT NULL, 
 last_updated DATE, 
 country_id INT

 );
 DESC city;
 
INSERT INTO city (id, name, state, last_updated, country_id)
VALUES
(1, 'New York', 'NY', '2022-01-01', 1),
(2, 'Los Angeles', 'CA', '2022-01-01',1),
(3, 'Chicago', 'IL','12022-01-01', 1),
(4,'Houston','2022-01-01', 1),
(5,'Phoenix', 'AZ', '2022-01-01', 1), 
(6, 'Philadelphia', 'PA', '2022-01-01', 1), 
(7, 'San Antonio', 'TX','2022-01-01', 1),
(8,'San Diego', 'CA', '2022-01-01', 1), 
(9, 'Dallas', 'X', '2022-01-01', 1),
(10, 'San Jose', 'CA', '2022-01-01', 1), 
(11, 'Austin', 'TX', '2022-01-01', 1),
(12,'Jacksonville', 'FL', '2022-01-01', 1),
(13,'Fort Worth', 'TX', '2022-01-01', 1),
(14,'Columbus', 'OH', '2022-01-01', 1),
(15,'San Francisco', 'CA', '2022-01-01', 1),
(16,'Charlotte', 'NC', '2022-01-01', 1),
(17,'Indianapolis', 'IN','2022-01-01', 1),
(18,'Seattle', 'WA', '2022-01-01', 1),
(19,'Denver', 'CO', '2022-01-01', 1),
(20,'Washington', 'DC', '2022-01-01', 1);

SELECT 
    c.first_name,
    c.last_name,
    a.house_number,
    a.street,
    a.postcode,
    city.city_name
FROM 
    address a
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    customer c ON a.customer_id = c.customer_id
GROUP BY 
    ci.city_name;

CREATE TABLE country (
id INTEGER PRIMARY KEY, 
name varcharacter (50) NOT NULL, 
continent VARCHAR (50) NOT NULL, 
last_updated DATE NOT NULL
);
DESC country;

INSERT INTO city (id, name, state, last_updated, country_id)
VALUES
(1,'New York', 'NY', '2022-01-01', 1), 
(2, 'Los Angeles', 'CA', '2022-01-01', 1),
(3,'Chicago','ILIA','2022-01-01', 1),
(4,'Houston','TX''2022-01-01', 1),
(5, 'Phoenix', 'AZ','2022-01-01', 1),
(6, 'Philadelphia', 'PA', '2022-01-01', 1), 
(7, 'San Antonio' , 'X', '2022-01-01', 1), 
(8, 'San Diego', 'CA', '2022-01-01', 1),
(9,'Dallas','TX', '2022-01-01', 1),
(10,'San Jose', 'CA', '2022-01-01', 1),
(11,'Austin', 'TX', '2022-01-01', 1),
(12,'Jacksonville', 'FL', '2022-01-01', 1),
(13,'Fort Worth', 'TX', '2022-01-01', 1),
(14,'Columbus', 'OH', '2022-01-01', 1),
(15,'San Francisco', 'CA', '2022-01-01', 1),
(16,'Charlotte', 'NC', '2022-01-01', 1),
(17,'Indianapolis''IN', '2022-01-01', 1),
(18,'Seattle','WA', '2022-01-01', 1),
(19,'Denver', 'CO', '2022-01-01', 1),
(20,'Washington', 'DC', '2022-01-01', 1);

SELECT 
    co.name,
    ci.name,
    a.house_number,
    a.street,
    a.postcode
FROM 
    address a
LEFT JOIN 
    city ci ON a.city_id = ci.city_id
LEFT JOIN 
    country co ON ci.country_id = co.country_id;


CREATE TABLE login ( 
id INT PRIMARY KEY, 
email VARCHAR (255) , 
phone_number VARCHAR (20), 
create_date DATE, 
last_login TIMESTAMP,
 account_status VARCHAR (50), 
 account_verified BOOLEAN, 
 login_details_id INT
);

DESC login;
INSERT INTO login (id, email, phone_number, create_date, last_login, account_status, account_verified, login_details_id)
VALUES
(1, 'john. doe@example.com', '1234567890', '2022-01-01', '2022-01-01 12:00:00', 'active', true, 1), 
(2, 'jane.smith@example.com','0987654321','12022-01-02', '12022-01-02 12:00:00', 'active', true, 2),
(3,'bob. johnson@example. com','5555555555', '2022-01-03', '2022-01-03 12:00:00', 'inactive', false, 3),
(4,'amy.nguyen@example.com', '1112223333', '2022-01-04', '2022-01-04 12:00:00','active', true, 4),
(5, 'james. kim@example. com','4444444444', '2022-01-05', '2022-01-05 12:00:00', 'inactive', false, 5),
(6, 'emily. chang@example.com','7777777777','2022-01-06', '2022-01-06 12:00:00', 'active', true, 6),
(7,'david.ng@example.com', '9999999999','9999999999', '2022-01-07',' 2022-01-07 12:00:00', 'inactive', false, 7),
(8,'Kate. harrison@example. com', '3333333333', '2022-01-08, 2022-01-08 12:00:00' , 'active', true, 8),
(9, 'michael.kim@example.com','6666666666','2022-01-09', '2022-01-09 12:00:00', 'inactive', false, 9),
(10, 'sarah. chen@example. com', '2222222222', '2022-01-10', '2022-01-10 12:00:00', 'active', true, 10),
(11, 'tom. smith@example.com', '4445556666', '2022-01-11', '2022-01-11 12:00:00','inactive', false, 11),
(12, 'lisa.nguyen@example.com', '7778889999','12022-01-12', '2022-01-12 12:00:00', 'active', true, 12);

SELECT 
    ra.house_number,
    ra.street,
    ra.city,
    d.children,
    d.spouse,
    l.username,
    l.last_login
FROM 
    room_address ra
JOIN 
    dependents d ON ra.room_id = d.room_id
JOIN 
    login l ON d.customer_id = l.customer_id;

CREATE TABLE login_details ( 
id INT PRIMARY KEY, 
username VARCHAR (50) NOT NULL, 
password VARCHAR (50) NOT NULL, 
last_updated DATETIME NOT NULL, 
security_questions_id INT NOT NULL,
FOREIGN KEY (security_questions_id) 
REFERENCES security_questions (id)
);

DESC login_details;
INSERT INTO login_details (id, username, password, last_updated, security_questions_id)
VALUES
(1, 'user','password1','12022-01-01 10:00:00', 1),
(2, 'user2','password2','2022-01-02 10:00:00', 2),
(3, 'user3' 'password3','12022-01-03 10:00:00', 3),
(4, 'user4','password4','12022-01-04 10:00:00', 4),
(5, 'users','password5','2022-01-05 10:00:00', 5),
(6, 'users','password6', '2022-01-06 10:00:00', 6),
(7, 'user7','password7','2022-01-07 10:00:00', 7),
(8, 'user8','password8', '2022-01-08 10:00:00', 8),
(9, 'user9','password9', '2022-01-09 10:00:00', 9),
(10, 'user10','password10','2022-01-10 10:00:00', 10),
(11, 'user11','password11','2022-01-11 10:00:00', 11),
(12, 'user12','password12','12022-01-12 10:00:00', 12),
(13, 'user13','password13','12022-01-13 10:00:00', 13),
(14, 'user14','password14','12022-01-14 10:00:00', 14),
(15, 'user15','password15','12022-01-15 10:00:00', 15),
(16, 'user16','password16','2022-01-16 10:00:00', 16),
(17, 'user17','password17','12022-01-17 10:00:00', 17),
(18, 'user18', 'password18','2022-01-18 10:00:00', 18),
(19, 'user19','password19','2022-01-19 10:00:00', 19),
(20, 'user20','password20', '2022-01-20 10:00:00', 20);

SELECT 
    r.room_id,
    r.home_type,
    sq.first,
    sq.first_answer,
    ld.last_updated
FROM 
    room r
LEFT JOIN 
    security_questions sq ON r.customer_id = sq.customer_id
LEFT JOIN 
    login_details ld ON r.customer_id = ld.customer_id;


CREATE TABLE security_questions (
 id  INT PRIMARY KEY, 
 first VARCHAR (255), 
 first_answer VARCHAR (255) , 
 second VARCHAR (255), 
 second_answer VARCHAR (255) ,
 third VARCHAR (255), 
 third_answer VARCHAR (255)
 );
 DESC security_questions;
 
INSERT INTO security_questions (first, first_answer, second, second_answer, third, third_answer)
VALUES
('What was the name of your first pet?', 'Fluffy', 'What is your favorite color?', 'Blue', 'What city were you born in?', 'New York', 'What was the name of your high school?'),
('Central High', 'What is your mothers maiden name?', 'Smith', 'What is your favorite movie?', 'The Godfather'),
('What is your favorite food?', 'Pizza','What is the name of your favorite teacher?','Mrs. Johnson', 'What is your favorite hobby?', 'Reading'),
('What was the make of your first car?','Toyota','What is your fathers middle name?','David','What is your favorite vacation spot?','Hawaii'),
('What is your favorite book?','To Kill a Mockingbird','What is your favorite band?','The Beatles', 'What is your favorite sports team?', 'New York Yank'),
('What is your favorite animal?', 'Dog', 'What is your favorite restaurant?','Cheesecake Factory', 'What is your favorite TV show?','Game of Thrones'),
('What is your favorite game?','Chess','What is your favorite fruit?','Strawberry', 'What is your favorite social media platform?','Instagram'),
('What is your favorite type of music?','Rock','What is vour favorite childhood memory?','Going to the beach with family','What is your favorite season'),
('What is your favorite auote?','Be the change You wish to see in the world.' ,' Gandhi','What is your favorite flower?','Rose','What is your favorite rose?', ' tulip'),
('What is your favorite superhero?','Spiderman','What is your favorite drink?', 'Coffee','What is your favorite place to shop?','Amazon'),
('What was your first job?', 'Babysitting', 'What is your favorite type of cuisine?', 'Italian', 'What is your favorite thing to do on weekends?'),
('What was your childhood nickname?','Buddy', 'What is your favorite app?', 'Spotify', 'What is your favorite color?', 'Green'),
('What is your favorite board game?', 'Monopoly', 'What is your favorite type of cheese?','Cheddar','What is your favorite type of tea?', 'Green tea'),
('What is your favorite car?','Ferrari','What is your favorite holiday?','Christmas','What is your favorite type of weather?', 'Sunny'),
('What is your favorite tvpe of shoe?','Sneakers','What is vour favorite tvpe of pasta?','Spaghetti', 'What is your favorite type of nut?','Almonds'),
('What is your favorite animal at the zoo?','Lion','What is your favorite type of coffee?', 'Cappuccino','What is your favorite type of cookie?','Chocol'),
('What is your favorite type of weather?','Rainv','What is vour favorite TV show as a child?','SpongeBob SquarePants','What is your favorite cartoon chi'),
('What was the name of vour first crush?','Johnny', 'What is your favorite musical instrument?','Piano','What is your favorite scent?', 'Lavender'),
('What is your favorite type of pizza?','Pepperoni','What is vour favorite type of dessert?','Ice cream','What is your favorite type of fish?', 'Salmon');


SELECT 
    sq.customer_id,
    sq.question,
    ld.last_updated
FROM 
    security_questions sq
LEFT JOIN 
    login_details ld ON sq.customer_id = ld.customer_id;


CREATE TABLE reservations (
 id INT PRIMARY KEY,
reservation_type VARCHAR (255),
 booking_date DATE, 
 start_date DATE, 
 end_date DATE, 
 last_updated TIMESTAMP, 
 room_id INT, 
 payment_id INT,
FOREIGN KEY (room_id) REFERENCES rooms (id)
);
DESC reservations;

INSERT INTO reservations (reservation_type, booking_date, start_date, end_date, last_updated, room_id, payment_id)
VALUES
('Standard','2023-05-01', '2023-05-15', '2023-05-20', NOW(), 1, 1),
('Deluxe', '2023-05-02', '2023-05-18', '2023-05-25', NOW(), 2, 2),
('Standard','12023-05-031', '2023-05-10', '2023-05-12', NOW(), 3, 3),
('Deluxe','12023-05-05','2023-06-01', '2023-06-07', NOW(), 4, 4),
('Standard','12023-05-08', '2023-05-20', '2023-05-22', NOW(), 5, 5),
('Deluxe','12023-05-09','2023-05-30', '2023-06-03', NOW(), 6, 6),
('Standard','2023-05-10', '2023-05-15' ,'2023-05-16', NOW(), 7, 7),
('Deluxe','12023-05-12','2023-06-05', '2023-06-10', NOW(), 8, 8),
('Standard','2023-05-134', '2023-05-234', '2023-05-25', NOW(), 9, 9),
('Deluxe','2023-05-15' , '2023-06-08', '2023-06-12', NOW(), 10, 10),
('Standard','2023-05-16' '2023-05-20', '2023-05-21', NOW(), 11, 11),
('Deluxe','12023-05-18','2023-06-02', '2023-06-07', NOW(), 12, 12),
('Standard', '2023-05-19', '2023-05-25' , '2023-05-27', NOW(), 13, 13),
('Deluxe','17073-05_77112023-06-10' ,'12023-06-14', NOW(), 14, 14),
('Standard','12023-05-23','2023-05-26' ,'2023-05-28', NOW(), 15, 15),
('Deluxe', '2023-05-25' ,'2023-06-12', '2023-06-16', NOW(), 16, 16),
('Standard','2023-05-26', '2023-05-31', '2023-06-02', NOW(), 17, 17),
('Deluxe','2023-05-28','2023-06-15', '2023-06-20', NOW(), 18, 18),
('Standard', '2023-05-29' , '2023-06-02', '2023-06-04', NOW(), 19, 19),
('Deluxe', '2023-05-30','12023-06-18', '2023-06-22', NOW(), 20, 20);

SELECT 
    r.reservation_id,
    r.start_date,
    r.end_date,
    p.payment_id,
    p.price,
    ro.home_type,
    ro.price_per_night
FROM 
    reservations r
INNER JOIN 
    payment p ON r.reservation_id = p.reservation_id
INNER JOIN 
    room ro ON r.room_id = ro.room_id;

CREATE TABLE room (
  id INT PRIMARY KEY,
  home_type VARCHAR(255),
  total_bedrooms INT,
  total_bathrooms INT,
  published_date DATE,
  room_address_id INT,
  rules_id INT
);
DESC room;
INSERT INTO room (id, home_type, total_bedrooms, total_bathrooms, published_date, room_address_id, rules_id)
VALUES
  (1, 'Apartment', 2, 1, '2022-01-15', 100, 200),
  (2, 'House', 4, 2, '2022-02-01', 101, 201),
  (3, 'Condo', 1, 1, '2022-02-15', 102, 202),
  (4, 'Townhouse', 3, 2, '2022-03-01', 103, 203),
  (5, 'Apartment', 1, 1, '2022-03-15', 104, 204),
  (6, 'House', 5, 3, '2022-04-01', 105, 205),
  (7, 'Condo', 2, 2, '2022-04-15', 106, 206),
  (8, 'Townhouse', 3, 2, '2022-05-01', 107, 207),
  (9, 'Apartment', 2, 1, '2022-05-15', 108, 208),
  (10, 'House', 4, 3, '2022-06-01', 109, 209),
  (11, 'Condo', 1, 1, '2022-06-15', 110, 210),
  (12, 'Townhouse', 3, 2, '2022-07-01', 111, 211),
  (13, 'Apartment', 1, 1, '2022-07-15', 112, 212),
  (14, 'House', 6, 4, '2022-08-01', 113, 213),
  (15, 'Condo', 2, 2, '2022-08-15', 114, 214),
  (16, 'Townhouse', 4, 3, '2022-09-01', 115, 215),
  (17, 'Apartment', 2, 1, '2022-09-15', 116, 216),
  (18, 'House', 3, 2, '2022-10-01', 117, 217),
  (19, 'Condo', 1, 1, '2022-10-15', 118, 218),
  (20, 'Townhouse', 4, 2, '2022-11-01', 119, 219);
SELECT 
  res.id, 
  res.check_in_date, 
  res.check_out_date, 
  res.room_id, 
  res.guest_id, 
  r.rules_description, 
  r.rule_value, 
  l.username, 
  l.email
FROM 
  reservation res 
  JOIN rules r ON res.rule_id = r.id 
  JOIN login_details l ON res.guest_id = l.id
ORDER BY 
  res.check_in_date ASC;

CREATE TABLE room_address (
room_id INT PRIMARY KEY, 
house_no VARCHAR (50), 
street VARCHAR (100), 
city VARCHAR (100), 
state VARCHAR (100) , 
country_id INT, 
room_owner_id INT,
amenities VARCHAR (200),
 
CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES country(id) ,
CONSTRAINT fk_room_owner_id FOREIGN KEY (room_owner_id) REFERENCES room_owner (id)
);
DESC room_address;
INSERT INTO room_address (id, house_no, street, city, state, country_id, room_owner_id, amenities)
VALUES (1,'123', 'Main St', 'New York','NY', 1, 1, 'Wi-Fi, air conditioning, free parking'),
(2, '456', 'Oak Ave', 'San Francisco','CA', 1, 2, 'Swimming pool, gym, breakfast'),
(3, '789','Elm St','Los Angeles',' CA', 3, 'Free breakfast, airport shuttle'),
(4,'1101','Maple St','Seattle','WA', 4,'Parking, Wi-Fi'),
(5,'12341','Pine St','Portland','OR', 1, 5,'Free parking, pet-friendly'),
(6, '567','Cedar Ave','Denver','CO',1, 6, 'Kitchen, Wi-Fi'),
(7,'890','Willow Rd','Chicago','IL', 1, 7, 'Hot tub, gym, free parking'),
(8, '111', 'Birch St', 'Miami', 'FL', 1, 8, 'Beach access, pool, Wi-Fi'),
(9, '1222','Spruce Ave','Austin', 'TX', 1, 9, 'Free breakfast, gym'),
(10,'13331','Sycamore Ln','Nashville','TN', 1, 10, 'Parking, kitchen'),
(11, 'Man lewood Dr','Boston','MA', 1, 11,'Free parking, pet-friendly'),
(12, '555','Chestnut St','Washington', 'DC', 1, 12,'Gym, Wi-Fi'),
(13, '666','Elmwood Ave','San Diego','CA', 1, 13, 'Pool, breakfast, parking'),
(14,'777','Pine Rd','Las Vegas','NV', 1, 14, 'Free parking, gym, Wi-Fi'),
(15,'888', 'Oakwood Ln', 'New Orleans','LA', 1, 15, 'Breakfast, parking'),
(16, '999','Cherry St', 'Philadelphia','PA', 1, 16, 'Gym, Wi-Fi'),
(17,'1121','Chestnut Hill','Dallas',1, 17,'Free breakfast, parking'),
(18,'12321','Man lewood Ave','Atlanta','GA',1, 18,'Swimming pool, gym, kitchen'),
(19,'343','Elmwood Dr','Houston','TX', 1, 19,'Free parking, pet-friendly');

SELECT
    ra.street,
    ra.house_no,
    ci.city_name,
    ro.first_name,
    ro.gender_email
FROM
    room_address ra
INNER JOIN
    city ci ON ra.city_id = ci.city_id
INNER JOIN
    room_owner ro ON ra.room_owner_id = ro.owner_id
GROUP BY
    ci.city_name,
    ro.owner_name;


CREATE TABLE room_owner (
id INT NOT NULL PRIMARY KEY,
 first_name VARCHAR (50) NOT NULL, 
 last_name VARCHAR (50) NOT NULL, 
 address VARCHAR (255) NOT NULL, 
 gender VARCHAR (10) NOT NULL,
 age INT NOT NULL
);
DESC room_owner;
INSERT INTO room_owner (id, first_name, last_name, address, gender, age)
VALUES
(1,'John',' Doe','123 Main St', 'Apt 4B','Male', 35),
(2,'Jane','Smith','456 Oak Rd','Female', 28),
(3, 'David','Lee','789 Pine Ave', 'Male', 42),
(4,'Sarah','Johnson','10 Elm St', 'Unit 2','Female', 31),
(5,'Michael','Brown','22 Maple Dr','Male', 46),
(6,'Emilv','Davis''1321', '1st St','Female', 25),
(7,'James','Wilson','456 2nd Ave, Apt 3C', 'Male', 39),
(8,'Avery','Garcia','1789 3rd St','Non-binary', 29),
(9,'Daniel','Tavlor','555 Elmwood Ave, Apt 7', 'Male', 33),
(10, 'Grace','Lopez','777 Oakwood Blvd', 'Female', 27),
(11, 'Oliver', 'Wright','888 Pine Rd, Apt 12', 'Male', 44),
(12, 'Chloe', 'Scott', '999 Maple Ave, Unit 5','Female', 26),
(13, 'William', 'Nguyen', '111 Birch St', 'Male', 30), (14, 'Ava', 'Gonzalez','222 Oak Rd', 'Female', 24),
(15,'Benjamin','Perez','333 Pine Ave','Male', 40),
(16, 'Sofia','Rivera', '444 Cedar St, Apt 2A','Female', 23),
(17,'Ethan', 'Kim',  '555 Elm St', 'Male', 38),
(18,'Tsabella','Smith','666 Maplewood', 'Dr','Female', 22),
(19,'Mason','Lee', '777 Oakwood Rd', 'Apt 9B','Male', 41),
(20, 'Emma', 'Martin', '888 Pine Ave', 'Unit 6', 'Female', 21);

SELECT 
    r.room_id, 
    r.first_name, 
    r.last_name, 
    r.price_per_night, 
    a.gender, 
    a.street, 
    a.city
FROM 
    room_owner AS o 
    LEFT JOIN room_address AS a ON o.address_id = a.address_id 
    LEFT JOIN room AS r ON o.owner_id = r.owner_id;


 CREATE TABLE rules (
id INT PRIMARY KEY, 
pets BOOLEAN, 
smoking BOOLEAN
);
DESC rules;
INSERT INTO rules (id, pets, smoking)
 VALUES
(1, true, false),
(2, false, true), 
(3, true, true), 
(4, false, false), 
(5, true, false), 
(6, false, true), 
(7, true, true), 
(8, false, false), 
(9, true, false),
(10, false, true),
(11, true, true), 
(12, false, false), 
(13, true, false), 
(14, false, true), 
(15, true, true), 
(16, false, false),
(17, true, false), 
(18, false, true), 
(19, true, true),
(20, false, false);

SELECT r.rule_name, rm.room_type, rm.bed_type, rm.price_per_night
FROM rules r
LEFT JOIN room rm ON r.room_id = rm.room_id;


CREATE TABLE payment ( 
id INT PRIMARY KEY,
 mode VARCHAR (50),
 price DECIMAL (10, 2),
 discounts DECIMAL(10, 2),
 total_price DECIMAL (10, 2), 
 payment_status VARCHAR (50), 
 reviews_id INT
 );
 DESC payment;
INSERT INTO payment (id, mode, price, discounts, total_price, payment_status, reviews_id)
VALUES
(1, 'Credit Card', 150.00, 20.00, 130.00, 'Paid', 1),
(2, 'Debit Card', 200.00, 0.00, 200.00, 'Paid', 2),
(3, 'PayPal', 100.00, 10.00, 90.00, 'Paid', 3),
(4, 'Cash', 300.00, 50.00, 250.00, 'Paid', 4),
(5, 'Check', 500.00, 0.00, 500.00, 'Paid', 5),
(6, 'Credit Card', 250.00, 30.00, 220.00, 'Paid', 6),
(7,'Debit Card', 150.00, 20.00, 130.00, 'Paid', 7),
(8, 'PayPal', 350.00, 0.00, 350.00, 'Paid', 8),
(9,'Cash', 100.00, 10.00, 90.00, 'Paid', 9), (10, 'Check', 200.00, 0.00, 200.00, 'Paid', 10),
(11,'Credit Card', 100.00, 0.00, 100.00, 'Paid', 11), 
(12, 'Debit Card', 50.00, 5.00, 45.00, 'Paid', 12),
 (13, 'PayPal', 75.00, 0.00, 75.00, 'Paid', 13),
(14,'Cash', 150.00, 20.00, 130.00, 'Paid', 14),
(15,'Check', 300.00, 50.00, 250.00, 'Paid', 15), 
(16, 'Credit Card', 200.00, 0.00, 200.00, 'Paid', 16), 
(17, 'Debit Card', 100.00, 10.00, 90.00, 'Paid', 17),
(18, 'PayPal', 50.00, 5.00, 45.00, 'Paid', 18),
(19,'Cash', 75.00, 0.00, 75.00, 'Paid', 19),
(20, 'Check', 150.00, 20.00, 130.00, 'Paid', 20);

SELECT 
  payment.payment_id, 
  payment.price, 
  payment.status, 
  reservations.reservation_id, 
  reservations.start_date, 
  reservations.end_date, 
  reviews.stars, 
  reviews.comments
FROM 
  payment
  INNER JOIN reservations ON payment.reservation_id = reservations.reservation_id
  LEFT JOIN reviews ON reservations.room_id = reviews.room_id AND reservations.checkout_date < reviews.review_date
ORDER BY 
  payment.payment_date DESC;


CREATE TABLE reviews (
id INT NOT NULL AUTO_INCREMENT, 
stars INT NOT NULL, 
comments TEXT, 
recommend BOOLEAN,
 PRIMARY KEY (id)
 );
 DESC reviews;
INSERT INTO reviews (stars, comments, recommend) VALUES

(5, 'This place was amazing! The host was so welcoming and the room was clean and comfortable. Highly recommend!', true),
(4, 'Great location and value for money. Room was clean and had all necessary amenities. Only downside was a bit of noise from the street.', true),
(3, 'The room was decent but could have been cleaner. Some of the amenities were also not working properly. Would NOT recommend.', false),
(5, 'Perfect stay! The room was spacious and had a great view. Host was super friendly and accommodating. Will definitely stay here again.', true), 
(2, 'Unfortunately, our stay was not pleasant. The room was not clean and had a bad odor. The host did not seem very interested in making our stay comfortable. Would not recommend.', false), 
(4, 'Overall, a good experience. The room was nice and clean, and the location was convenient. The only downside was that the check-in process was a bit confusing.', true),
(3, 'The room was ok but not great. The bed was uncomfortable and some of the amenities were missing. Host was friendly but not very responsive to our needs.', false),
(5, 'Absolutely loved our stay here! The room was beautiful and the host went above and beyond to make us feel welcome. Highly recommend!', true),
(4, 'Good value for money. The room was clean and comfortable, and the location was convenient. Only downside was a bit of noise from the street.', true),
(1, 'The worst experience ever! The room was filthy and smelled terrible. The host was rude and unhelpful. Would never stay here again.', false),
(5, 'Could not have asked for a better stay! The room was perfect and the host was so friendly and helpful. Will definitely be back!', true), 
(2, 'Disappointing stay. The room was not as advertised and had several issues. Host was unresponsive and did not seem interested in fixing the problems.', false), 
(4, 'Overall a good experience. The room was clean and comfortable, and the host was friendly and accommodating. Would recommend.', true),
(3, 'The room was average but not great. Some of the amenities were not working and the location was a bit far from the city center. Host was friendly but not very helpful.' , false),
(5, 'Amazing stay! The room was beautiful and had everything we needed. Host was incredibly friendly and welcoming. Highly recommend!', true), 
(4, 'Good value for money. The room was clean and comfortable, and the location was convenient. The only downside was that the check-in process was a bit confusing.', true),
(2, 'Terrible experience. The room was dirty and had several issues. Host was unresponsive and unhelpful. Would not recommend.', false),
(5, 'Could not have asked for a better stay! The room was perfect and the host was so friendly and helpful. Will definitely be back!', true),
(4, 'Great stay! The room was clean and comfortable, and the location was convenient. Host was friendly and accommodating. Would recommend.', true),
(3, 'The room was ok but not great. Some of the amenities were missing and the location was a bit far from the city center. Host was friendly but not very responsive.', false);

SELECT 
p.payment_id,
 p.price, 
 p.payment_status, 
 r.stars,
 r.comments
FROM payment p
LEFT JOIN reservations res ON p.reservation_id = res.reservation_id
LEFT JOIN room r ON res.room_id = r.room_id
LEFT JOIN stars rev ON p.reservation_id = rev.reservation_id;


CREATE TABLE facilities (
id INT NOT NULL AUTO_INCREMENT, 
hot_tub BOOLEAN NOT NULL DEFAULT FALSE,
EV_charger BOOLEAN NOT NULL DEFAULT FALSE,
pool BOOLEAN NOT NULL DEFAULT FALSE, 
gym BOOLEAN NOT NULL DEFAULT FALSE, 
free_parking BOOLEAN NOT NULL DEFAULT FALSE, 
entertainment_id INT, 
PRIMARY KEY (id),
FOREIGN KEY (entertainment_id) REFERENCES entertainment (id)
 );
 DESC failities;
 INSERT INTO facilities (hot_tub, EV_charger, pool, gym, free_parking, entertainment_id)
VALUES

(TRUE, FALSE, TRUE, TRUE, TRUE, 1),
(FALSE, TRUE, FALSE, TRUE, FALSE, 2),
(TRUE, FALSE, TRUE, FALSE, TRUE, 3),
(FALSE, FALSE, TRUE, TRUE, TRUE, 4),
(TRUE, TRUE, FALSE, FALSE, FALSE, 5),
(FALSE, TRUE, TRUE, FALSE, TRUE, 6),
(TRUE, FALSE, FALSE, TRUE, FALSE, 7),
(FALSE, TRUE, TRUE, FALSE, FALSE, 8),
(FALSE, FALSE, TRUE, TRUE, TRUE, 9),
(TRUE, FALSE, TRUE, FALSE, TRUE, 10),
(TRUE, TRUE, FALSE, TRUE, FALSE, 11), 
(FALSE, TRUE, FALSE, TRUE, FALSE, 12),
(TRUE, FALSE, TRUE, FALSE, TRUE, 13), 
(FALSE, TRUE, TRUE, FALSE, TRUE, 14),
(TRUE, TRUE, FALSE, TRUE, FALSE, 15),
(FALSE, TRUE, FALSE, TRUE, FALSE, 16),
(TRUE, FALSE, TRUE, FALSE, TRUE, 17), 
(FALSE, TRUE, TRUE, FALSE, TRUE, 18),
(TRUE, TRUE, FALSE, TRUE, FALSE, 19),
(FALSE, TRUE, FALSE, TRUE, FALSE, 20) ;


SELECT
 f.facility_id, 
 f.hot_tub,
 a.kitchen,
 e.tv
FROM facilities f
LEFT JOIN amenities a ON f.amenity_id = a.amenity_id
LEFT JOIN entertainment e ON f.entertainment_id = e.entertainment_id;



CREATE TABLE amenities ( 
id INT PRIMARY KEY, 
kitchen BOOLEAN, 
air_conditioning BOOLEAN, 
heating BOOLEAN, 
washer BOOLEAN,
 dryer BOOLEAN, 
internet BOOLEAN, 
facilities_id INT,
FOREIGN KEY (facilities_id) REFERENCES facilities (id)
);
DESC amenities;
INSERT INTO amenities (id, kitchen, air_conditioning, heating, washer, dryer, internet, facilities_id)
VALUES

(1, true, true, true, true, true, true, 1), 
(2, false, true, true, false, true, true, 2), 
(3, true, false, true, true, false, true, 3), 
(4, true, true, false, false, true, false, 4), 
(5, false, true, true, true, false, true, 5), 
(6, true, true, false, true, true, false, 6), 
(7, false, false, true, false, true, true, 7), 
(8, true, false, true, false, false, true, 8), 
(9, false, true, false, true, true, false, 9), 
(10, true, true, true, false, false, false, 10), 
(11, true, false, false, true, true, true, 11), 
(12, false, true, true, false, true, false, 12), 
(13, true, false, true, false, false, true, 13), 
(14, false, true, false, true, true, false, 14), 
(15, true, false, false, true, false, true, 15), 
(16, true, true, false, false, true, false, 16), 
(17, false, false, true, true, false, true, 17), 
(18, true, false, true, false, true, false, 18), 
(19, false, true, false, true, false, true, 19), 
(20, true, true, false, true, false, false, 20);

SELECT 
  ra.street, 
  f.hot_tub 
FROM 
  amenities AS a 
  JOIN facilities AS f ON a.facility_id = f.facility_id 
  JOIN room_address AS ra ON a.room_id = ra.room_id;



CREATE TABLE entertainment (
id INT NOT NULL PRIMARY KEY, 
tv TINYINT(1) DEFAULT 0, 
sound_system TINYINT(1) DEFAULT 0,
projector TINYINT (1) DEFAULT 0, 
water_front TINYINT (1) DEFAULT 0, 
beach_front TINYINT (1) DEFAULT 0
);

DESC entertainment;
INSERT INTO entertainment (id, tv, sound_system, projector, water_front, beach_front)
VALUES
(1, 1, 1, 0, 0, 0),
(2, 0, 1, 1, 0, 0),
(3, 1, 0, 0, 1, 0),
(4, 0, 0, 1, 0, 1),
(5, 1, 1, 1, 0, 0),
(6, 0, 1, 0, 1, 0),
(7, 1, 0, 1, 0, 1),
(8, 0, 1, 1, 1, 0),
(9, 1, 0, 0, 0, 1),
(10, 0, 0, 1, 1, 1),
(11, 1, 1, 0, 1, 0),
(12, 0, 1, 1, 0, 1),
(13, 1, 0, 1, 1, 1),
(14, 0, 1, 1, 1, 0),
(15, 1, 1, 0, 0, 1),
(16, 0, 0, 1, 1, 0),
(17, 1, 0, 1, 0, 0),
(18, 0, 1, 0, 0, 1),
(19, 1, 0, 1, 1, 1),
(20, 0, 1, 1, 1, 1);

SELECT f.facility_name, e.entertainment_name
FROM facilities f
LEFT JOIN entertainment e ON f.facility_id = e.facility_id;


create database myDB;