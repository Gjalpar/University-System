DROP DATABASE IF EXISTS eren;
CREATE DATABASE eren;
USE eren;

CREATE TABLE faculty (
	faculty_id int(11) NOT NULL,
	faculty_name varchar(50) NOT NULL UNIQUE,
	dean_name varchar(50) NOT NULL,
	dean_username varchar(50) NOT NULL UNIQUE,
	dean_password varchar(50) NOT NULL,
	head_of_secretary_name varchar(50) NOT NULL,
	head_of_secretary_username varchar(50) NOT NULL UNIQUE,
	head_of_secretary_password varchar(50) NOT NULL,
	PRIMARY KEY(faculty_id)
);

CREATE TABLE department (
	department_id int(11) NOT NULL,
	department_name varchar(50) NOT NULL,
	head_of_department_name varchar(50) NOT NULL,
	head_of_department_username varchar(50) NOT NULL UNIQUE,
	head_of_department_password varchar(50) NOT NULL,
	faculty_id int(11) NOT NULL,
	PRIMARY KEY(department_id),
	FOREIGN KEY (faculty_id) REFERENCES faculty (faculty_id)
);

CREATE TABLE employee (
	employee_id int(11) NOT NULL,
	employee_name varchar(50) NOT NULL,
	username varchar(50) NOT NULL UNIQUE,
	password varchar(50) NOT NULL,
	role varchar(50) NOT NULL,
	department_id int(11) NOT NULL,
	PRIMARY KEY(employee_id),
	FOREIGN KEY (department_id) REFERENCES department (department_id)
);

CREATE TABLE courses (
	courses_id int(11) NOT NULL,
	courses_name varchar(100) NOT NULL,
	courses_day varchar(10) NOT NULL,
	courses_time time default NULL,
	department_id int(11) NOT NULL,
	PRIMARY KEY(courses_id),
	FOREIGN KEY (department_id) REFERENCES department (department_id)
);

CREATE TABLE exam (
	exam_id int(11) NOT NULL,
	exam_date date default NULL,
	exam_time time default NULL,
	courses_name varchar(100) NOT NULL,
	employee_id int(11) NOT NULL,
	PRIMARY KEY(exam_id),
	FOREIGN KEY (employee_id) REFERENCES employee (employee_id)
);

INSERT INTO faculty (faculty_id, faculty_name, dean_name, dean_username, dean_password, head_of_secretary_name, head_of_secretary_username, head_of_secretary_password) VALUES
(1, "Faculty of Science", "Alice Johnson", "ajohnson1", ">V:d|dOxp{", "Emily Davis", "edavis1", "g)F@k1=l[T"),
(2, "Faculty of Business", "Brian Thompson", "bthompson2", "OH~(BN*O", "Sarah Miller", "smiller2", "HezAw2hn"),
(3, "Faculty of Social Sciences", "Carol Martinez", "cmartinez3", "^+]LUC[!", "Jessica Wilson", "jwilson3", "dDMIJB~Z"),
(4, "Faculty of Fine Arts", "David Brown", "dbrown4", ";VaVRM#x", "Sophia Moore", "smoore4", "xkk$Ip]q"),
(5, "Faculty of Information Technology", "Eva Garcia", "egarcia5", "ZNh\\%.ZR", "Robert Jackson", "rjackson5", "Oex9IB#2"),
(6, "Faculty of Health Sciences", "Frank Clark", "fclark6", "W3r@zK^N", "Patricia Lewis", "plewis6", "fLt0@L1!");

INSERT INTO department (department_id, department_name, head_of_department_name, head_of_department_username, head_of_department_password, faculty_id) VALUES
(1, "Physics", "George Evans", "gevans1", "snUP)uf", 1),
(2, "Chemistry", "Helen Baker", "hbaker2", "/Ju!,BsU", 1),
(3, "Biology", "Ian Green", "igreen3", "`%-6UoC%", 1),
(4, "Mathematics", "Jane Adams", "jadams4", "j[7iCg$f", 1),
(5, "Environmental Science", "Kevin Roberts", "kroberts5", "&E1Fe<QA", 1),
(6, "Management", "Laura Nelson", "lnelson6", "75C@`D{T", 2),
(7, "Marketing", "Martin Phillips", "mphillips7", "tgY637F0", 2),
(8, "Finance", "Nancy Turner", "nturner8", "YhJ^frpK", 2),
(9, "Accounting", "Oscar Cooper", "ocooper9", "8;9BcQ%W", 2),
(10, "International Business", "Paul White", "pwhite10", "zefoV%1G", 2),
(11, "Sociology", "Quincy King", "qking11", "-PC/YYV]", 3),
(12, "Psychology", "Rachel Scott", "rscott12", "vT@7yQh6", 3),
(13, "Political Science", "Samuel Edwards", "sedwards13", "L0p^#w7e", 3),
(14, "Anthropology", "Tina Lewis", "tlewis14", "2YH@7!lP", 3),
(15, "Economics", "Ursula Clark", "uclark15", "xNd@f9J#", 3),
(16, "Painting", "Victor Hernandez", "vhernandez16", "Ld5&x*89", 4),
(17, "Sculpture", "Wendy Young", "wyoung17", "6Lk#8gHp", 4),
(18, "Photography", "Xavier Rivera", "xrivera18", "4Jk&7@cZ", 4),
(19, "Graphic Design", "Yvonne Perry", "yperry19", "7Wm#2Bn8", 4),
(20, "Art History", "Zachary Collins", "zcollins20", "9Jp$3FwQ", 4),
(21, "Computer Science", "Amanda Clark", "aclark21", "bL6&7nT5", 5),
(22, "Software Engineering", "Brandon Lee", "blee22", "9Km@6HyR", 5),
(23, "Information Systems", "Catherine Walker", "cwalker23", "3Dp*7JuR", 5),
(24, "Cyber Security", "Dylan Hall", "dhall24", "4Lm%8PzT", 5),
(25, "Data Science", "Evelyn King", "eking25", "2Qj&6SrX", 5),
(26, "Nursing", "Fiona Harris", "fharris26", "5Tm*9JrP", 6),
(27, "Public Health", "Gordon Cooper", "gcooper27", "6Vk@2XpL", 6),
(28, "Physical Therapy", "Hannah Price", "hprice28", "7Wn#4YqT", 6),
(29, "Occupational Therapy", "Isaac Martinez", "imartinez29", "8Xl$5VzQ", 6),
(30, "Nutrition and Dietetics", "Jasmine Lewis", "jlewis30", "9Yn%3WrL", 6);

INSERT INTO employee (employee_id, employee_name, username, password, role, department_id) VALUES
-- Physics Department
(1, "Laura Peterson", "lpeterson1", "xT7$kL9#", "Assistant", 1),
(2, "Samuel Adams", "sadams5", "qR3&bN2@", "Assistant", 1),
(3, "Jessica Hall", "jhall3", "vF8@wM6%", "Assistant", 1),
(4, "Thomas Miller", "tmiller9", "yP4#zQ8!", "Secretary", 1),

-- Chemistry Department
(5, "David Wilson", "dwilson5", "D(>U9,F{", "Assistant", 2),
(6, "Sarah Johnson", "sjohnson6", "Fk$vZ;j&", "Assistant", 2),
(7, "James Lee", "jlee7", ")SQUKyZ{", "Secretary", 2),

-- Biology Department
(8, "Robert White", "rwhite8", "8)=y6Ce)", "Assistant", 3),
(9, "Patricia King", "pking9", "0#1)g/`C", "Assistant", 3),
(10, "Linda Clark", "lclark10", ">_q!]eYG", "Secretary", 3),

-- Mathematics Department
(11, "Daniel Martinez", "dmartinez11", "EEWABHBN", "Assistant", 4),
(12, "Elizabeth Moore", "emoore12", "uX,xm4J>", "Assistant", 4),
(13, "Matthew Taylor", "mtaylor13", "#a!9g9R_", "Secretary", 4),

-- Environmental Science Department
(14, "Barbara Anderson", "banderson14", "];aD{d[.", "Assistant", 5),
(15, "Charles Thomas", "cthomas15", "cA[qHT?S", "Assistant", 5),
(16, "Jessica Jackson", "jjackson16", "VKC1jSAb", "Secretary", 5),

-- Management Department
(17, "Jennifer White", "jwhite17", "hx/[TS=0", "Assistant", 6),
(18, "Michael Harris", "mharris18", "9&?F03N:", "Assistant", 6),
(19, "Laura Martin", "lmartin19", "0r=0RE-V", "Assistant", 6),
(20, "Christopher Thompson", "cthompson20", "M2q|D7?B", "Secretary", 6),

-- Marketing Department
(21, "Amanda Garcia", "agarcia21", "997/K[&(", "Assistant", 7),
(22, "Joshua Martinez", "jmartinez22", ",OCG2e@c", "Secretary", 7),

-- Finance Department
(23, "Lisa Rodriguez", "lrodriguez23", ".{skzE#s", "Assistant", 8),
(24, "Mark Lewis", "mlewis24", "RDu3,FOa", "Secretary", 8),

-- Accounting Department
(25, "Steven Lee", "slee25", "#lB@u'=+", "Assistant", 9),
(26, "Deborah Walker", "dwalker26", "J?)~|WaG", "Assistant", 9),
(27, "Anthony Hall", "ahall27", "wVtQ;U67", "Secretary", 9),

-- International Business Department
(28, "Mary Allen", "mallen28", "ykKM[YXP", "Assistant", 10),
(29, "Brian Young", "byoung29", "th/d1uX>", "Assistant", 10),
(30, "Dorothy Hernandez", "dhernandez30", "l1j2T-s2", "Secretary", 10),

-- Sociology Department
(31, "Kenneth King", "kking31", "@(Z(R7q0", "Assistant", 11),
(32, "Karen Wright", "kwright32", "os/J?V+7", "Assistant", 11),
(33, "George Lopez", "glopez33", "^i_'gdP4", "Secretary", 11),

-- Psychology Department
(34, "Adam Roberts", "aroberts34", "sG3#y6Dp", "Assistant", 12),
(35, "Sophia Hall", "shall35", "pL!9zTf^", "Assistant", 12),
(36, "Ethan Martinez", "emartinez36", "qMx@4oP!", "Secretary", 12),

-- Political Science Department
(37, "Olivia Moore", "omoore37", "nJk~6&bD", "Assistant", 13),
(38, "Noah Carter", "ncarter38", "wP$4dV2z", "Secretary", 13),

-- Anthropology Department
(39, "Emma Perez", "eperez39", "bC8t@4Lm", "Assistant", 14),
(40, "Liam Thompson", "lthompson40", "tQ9~!j7x", "Assistant", 14),
(41, "Ava Hall", "ahall41", "jP4#s6Yq", "Secretary", 14),

-- Economics Department
(42, "Mia Sanchez", "msanchez42", "lNp@3!aS", "Assistant", 15),
(43, "Elijah Garcia", "egarcia43", "wKo!3fPx", "Secretary", 15),

-- Painting Department
(44, "Harper Wilson", "hwilson44", "xM9#d8zE", "Assistant", 16),
(45, "Alexander King", "aking45", "rH6!qM7w", "Assistant", 16),
(46, "Madison Martinez", "mmartinez46", "zPq@5sLm", "Secretary", 16),

-- Sculpture Department
(47, "Charlotte Anderson", "canderson47", "dZ1!sL8q", "Assistant", 17),
(48, "Ethan Rodriguez", "erodriguez48", "gM2@jK3p", "Assistant", 17),
(49, "Benjamin Campbell", "bcampbell49", "hN3!rM9k", "Secretary", 17),

-- Photography Department
(50, "Amelia Clark", "aclark50", "bK5@zN6j", "Assistant", 18),
(51, "Daniel Thompson", "dthompson51", "jG8!lP2s", "Secretary", 18),

-- Graphic Design Department
(52, "Avery White", "awhite52", "mF3@kR7q", "Assistant", 19),
(53, "Sofia Walker", "swalker53", "pH6!fL8z", "Secretary", 19),

-- Art History Department
(54, "Jackson Lewis", "jlewis54", "qN2@lM9k", "Assistant", 20),
(55, "Scarlett Perez", "sperez55", "sJ9!pQ6m", "Secretary", 20),

-- Computer Science Department
(56, "Evelyn Taylor", "etaylor56", "rW6@mL8s", "Assistant", 21),
(57, "Lucas Rodriguez", "lwright57", "vK3!sQ9p", "Secretary", 21),

-- Software Engineering Department
(58, "Chloe Moore", "cmoore58", "tJ9@rM6l", "Assistant", 22),
(59, "Jack Rodriguez", "jrodriguez59", "wP7!zL4j", "Assistant", 22),
(60, "Adam Roberts", "aroberts60", "sG3#y6Dp", "Secretary", 22),

-- Information Systems Department
(61, "Olivia Moore", "omoore61", "nJk~6&bD", "Assistant", 23),
(62, "Noah Carter", "ncarter62", "wP$4dV2z", "Secretary", 23),

-- Cyber Security Department
(63, "Emma Perez", "eperez63", "bC8t@4Lm", "Assistant", 24),
(64, "Liam Thompson", "lthompson64", "tQ9~!j7x", "Assistant", 24),
(65, "Ava Hall", "ahall65", "jP4#s6Yq", "Secretary", 24),

-- Data Science Department
(66, "Mia Sanchez", "msanchez66", "lNp@3!aS", "Assistant", 25),
(67, "Elijah Garcia", "egarcia67", "wKo!3fPx", "Secretary", 25),

-- Nursing Department
(68, "Harper Wilson", "hwilson68", "xM9#d8zE", "Assistant", 26),
(69, "Alexander King", "aking69", "rH6!qM7w", "Assistant", 26),
(70, "Madison Martinez", "mmartinez70", "zPq@5sLm", "Secretary", 26),

-- Public Health Department
(71, "Charlotte Anderson", "canderson71", "dZ1!sL8q", "Assistant", 27),
(72, "Ethan Rodriguez", "erodriguez72", "gM2@jK3p", "Assistant", 27),
(73, "Benjamin Campbell", "bcampbell73", "hN3!rM9k", "Secretary", 27),

-- Physical Therapy Department
(74, "Amelia Clark", "aclark74", "bK5@zN6j", "Assistant", 28),
(75, "Daniel Thompson", "dthompson75", "jG8!lP2s", "Secretary", 28),

-- Occupational Therapy Department
(76, "Avery White", "awhite76", "mF3@kR7q", "Assistant", 29),
(77, "Sofia Walker", "swalker77", "pH6!fL8z", "Assistant", 29),
(78, "Jackson Lewis", "jlewis78", "qN2@lM9k", "Secretary", 29),

-- Nutrition and Dietetics Department
(79, "Scarlett Perez", "sperez79", "sJ9!pQ6m", "Assistant", 30),
(80, "Evelyn Taylor", "etaylor80", "rW6@mL8s", "Assistant", 30),
(81, "Lucas Wright", "lwright81", "vK3!sQ9p", "Secretary", 30);

INSERT INTO courses (courses_id, courses_name, courses_day, courses_time, department_id) VALUES
-- Physics Department (Department ID: 1)
(1, "Quantum Mechanics", 'Monday', '09:00', 1),
(2, "Astrophysics", 'Wednesday', '15:00', 1),
(3, "Statistical Mechanics", 'Friday', '11:00', 1),

-- Chemistry Department (Department ID: 2)
(4, "Organic Chemistry", 'Tuesday', '10:00', 2),
(5, "Analytical Chemistry", 'Thursday', '15:00', 2),
(6, "Inorganic Chemistry", 'Monday', '13:00', 2),

-- Biology Department (Department ID: 3)
(7, "Cell Biology", 'Wednesday', '13:00', 3),
(8, "Genetics", 'Friday', '11:00', 3),
(9, "Ecology", 'Monday', '15:00', 3),

-- Mathematics Department (Department ID: 4)
(10, "Calculus", 'Thursday', '09:00', 4),
(11, "Linear Algebra", 'Tuesday', '15:00', 4),
(12, "Probability Theory", 'Monday', '13:00', 4),

-- Environmental Science Department (Department ID: 5)
(13, "Climate Change", 'Wednesday', '11:00', 5),
(14, "Environmental Policy", 'Thursday', '15:00', 5),
(15, "Sustainability", 'Tuesday', '09:00', 5),

-- Management Department (Department ID: 6)
(16, "Strategic Management", 'Monday', '11:00', 6),
(17, "Human Resource Management", 'Wednesday', '15:00', 6),
(18, "Financial Management", 'Friday', '13:00', 6),

-- Marketing Department (Department ID: 7)
(19, "Consumer Behavior", 'Tuesday', '11:00', 7),
(20, "Marketing Research", 'Thursday', '15:00', 7),
(21, "Brand Management", 'Monday', '13:00', 7),

-- Finance Department (Department ID: 8)
(22, "Investment Analysis", 'Thursday', '11:00', 8),
(23, "Financial Modeling", 'Tuesday', '15:00', 8),
(24, "Corporate Finance", 'Monday', '13:00', 8),

-- Accounting Department (Department ID: 9)
(25, "Financial Accounting", 'Wednesday', '15:00', 9),
(26, "Managerial Accounting", 'Friday', '11:00', 9),
(27, "Auditing", 'Monday', '09:00', 9),

-- International Business Department (Department ID: 10)
(28, "Global Business Strategy", 'Friday', '11:00', 10),
(29, "International Marketing", 'Tuesday', '13:00', 10),
(30, "Cross-Cultural Management", 'Wednesday', '15:00', 10),

-- Sociology Department (Department ID: 11)
(31, "Social Theory", 'Monday', '15:00', 11),
(32, "Gender Studies", 'Wednesday', '09:00', 11),
(33, "Urban Sociology", 'Friday', '13:00', 11),

-- Psychology Department (Department ID: 12)
(34, "Cognitive Psychology", 'Thursday', '11:00', 12),
(35, "Developmental Psychology", 'Tuesday', '15:00', 12),
(36, "Abnormal Psychology", 'Monday', '13:00', 12),

-- Political Science Department (Department ID: 13)
(37, "Comparative Politics", 'Wednesday', '15:00', 13),
(38, "International Relations", 'Friday', '11:00', 13),
(39, "Public Policy Analysis", 'Monday', '09:00', 13),

-- Anthropology Department (Department ID: 14)
(40, "Cultural Anthropology", 'Thursday', '11:00', 14),
(41, "Archaeology", 'Tuesday', '13:00', 14),
(42, "Biological Anthropology", 'Wednesday', '15:00', 14),

-- Economics Department (Department ID: 15)
(43, "Microeconomics", 'Monday', '11:00', 15),
(44, "Macroeconomics", 'Wednesday', '15:00', 15),
(45, "Econometrics", 'Friday', '11:00', 15),

-- Painting Department (Department ID: 16)
(46, "Oil Painting", 'Tuesday', '13:00', 16),
(47, "Watercolor Techniques", 'Thursday', '09:00', 16),
(48, "Portrait Drawing", 'Monday', '15:00', 16),

-- Sculpture Department (Department ID: 17)
(49, "Stone Carving", 'Wednesday', '11:00', 17),
(50, "Metal Sculpture", 'Friday', '13:00', 17),
(51, "Ceramics", 'Monday', '13:00', 17),

-- Photography Department (Department ID: 18)
(52, "Digital Photography", 'Thursday', '15:00', 18),
(53, "Darkroom Techniques", 'Tuesday', '15:00', 18),
(54, "Photographic Composition", 'Monday', '09:00', 18),

-- Graphic Design Department (Department ID: 19)
(55, "Typography", 'Wednesday', '13:00', 19),
(56, "Brand Identity Design", 'Friday', '11:00', 19),
(57, "Printmaking", 'Monday', '13:00', 19),

-- Art History Department (Department ID: 20)
(58, "Renaissance Art", 'Thursday', '11:00', 20),
(59, "Modern Art", 'Tuesday', '13:00', 20),
(60, "Asian Art History", 'Wednesday', '15:00', 20),

-- Computer Science Department (Department ID: 21)
(61, "Algorithm Design", 'Monday', '09:00', 21),
(62, "Database Systems", 'Wednesday', '15:00', 21),
(63, "Web Development", 'Friday', '11:00', 21),

-- Software Engineering Department (Department ID: 22)
(64, "Software Testing", 'Tuesday', '11:00', 22),
(65, "Agile Software Development", 'Thursday', '15:00', 22),
(66, "Mobile Application Development", 'Monday', '13:00', 22),

-- Information Systems Department (Department ID:22),
(67, "Database Management", 'Wednesday', '13:00', 23),
(68, "Enterprise Systems", 'Friday', '11:00', 23),
(69, "Information Security", 'Monday', '15:00', 23),

-- Cyber Security Department (Department ID: 24)
(70, "Cyber Threat Intelligence", 'Thursday', '09:00', 24),
(71, "Ethical Hacking", 'Tuesday', '15:00', 24),
(72, "Digital Forensics", 'Monday', '09:00', 24),

-- Data Science Department (Department ID: 25)
(73, "Data Mining", 'Wednesday', '15:00', 25),
(74, "Machine Learning", 'Friday', '11:00', 25),
(75, "Big Data Analytics", 'Monday', '13:00', 25),

-- Nursing Department (Department ID: 26)
(76, "Medical-Surgical Nursing", 'Thursday', '11:00', 26),
(77, "Pediatric Nursing", 'Tuesday', '13:00', 26),
(78, "Mental Health Nursing", 'Wednesday', '15:00', 26),

-- Public Health Department (Department ID: 27)
(79, "Epidemiology", 'Monday', '09:00', 27),
(80, "Health Policy", 'Wednesday', '15:00', 27),
(81, "Community Health", 'Friday', '11:00', 27),

-- Physical Therapy Department (Department ID: 28)
(82, "Orthopedic Physical Therapy", 'Tuesday', '09:00', 28),
(83, "Neurological Physical Therapy", 'Thursday', '15:00', 28),
(84, "Geriatric Physical Therapy", 'Monday', '13:00', 28),

-- Occupational Therapy Department (Department ID: 29)
(85, "Hand Therapy", 'Wednesday', '15:00', 29),
(86, "Pediatric Occupational Therapy", 'Friday', '11:00', 29),
(87, "Mental Health Occupational Therapy", 'Monday', '13:00', 29),

-- Nutrition and Dietetics Department (Department ID: 30)
(88, "Clinical Nutrition", 'Thursday', '11:00', 30),
(89, "Sports Nutrition", 'Tuesday', '13:00', 30),
(90, "Community Nutrition", 'Wednesday', '15:00', 30);

INSERT INTO exam (exam_id, exam_date, exam_time, courses_name, employee_id) VALUES
-- Physics Department
(1, '2024-06-15', '15:00', "Quantum Mechanics", 3),
(2, '2024-06-18', '11:00', "Astrophysics", 2),
(3, '2024-06-20', '13:00', "Statistical Mechanics", 1),

-- Chemistry Department
(4, '2024-06-16', '13:00', "Organic Chemistry", 5),
(5, '2024-06-22', '09:00', "Analytical Chemistry", 6),
(6, '2024-06-21', '15:00', "Inorganic Chemistry", 5),

-- Biology Department
(7, '2024-06-15', '11:00', "Cell Biology", 9),
(8, '2024-06-18', '09:00', "Genetics", 9),
(9, '2024-06-20', '13:00', "Ecology", 8),

-- Mathematics Department
(10, '2024-06-16', '15:00', "Calculus", 11),
(11, '2024-06-23', '13:00', "Linear Algebra", 12),
(12, '2024-06-21', '11:00', "Probability Theory", 12),

-- Environmental Science Department
(13, '2024-06-17', '09:00', "Climate Change", 15),
(14, '2024-06-23', '11:00', "Environmental Policy", 14),
(15, '2024-06-21', '13:00', "Sustainability", 15),

-- Management Department
(16, '2024-06-18', '11:00', "Strategic Management", 19),
(17, '2024-06-24', '15:00', "Human Resource Management", 17),
(18, '2024-06-22', '13:00', "Financial Management", 18),

-- Marketing Department
(19, '2024-06-15', '11:00', "Consumer Behavior", 21),
(20, '2024-06-23', '09:00', "Marketing Research", 21),
(21, '2024-06-21', '13:00', "Brand Management", 21),

-- Finance Department
(22, '2024-06-16', '15:00', "Corporate Finance", 23),
(23, '2024-06-24', '13:00', "Investment Analysis", 23),
(24, '2024-06-22', '11:00', "Financial Modeling", 23),

-- Accounting Department
(25, '2024-06-17', '11:00', "Financial Accounting", 25),
(26, '2024-06-23', '13:00', "Managerial Accounting", 26),
(27, '2024-06-21', '09:00', "Auditing", 26),

-- International Business Department
(28, '2024-06-18', '11:00', "Global Business Strategy", 29),
(29, '2024-06-24', '13:00', "International Marketing", 28),
(30, '2024-06-22', '15:00', "Cross-Cultural Management", 28),

-- Sociology Department
(31, '2024-06-16', '15:00', "Social Theory", 32),
(32, '2024-06-23', '09:00', "Gender Studies", 31),
(33, '2024-06-21', '13:00', "Urban Sociology", 32),

-- Psychology Department
(34, '2024-06-17', '11:00', "Cognitive Psychology", 35),
(35, '2024-06-24', '15:00', "Developmental Psychology", 34),
(36, '2024-06-22', '13:00', "Abnormal Psychology", 34),

-- Political Science Department
(37, '2024-06-18', '15:00', "Comparative Politics", 37),
(38, '2024-06-24', '09:00', "International Relations", 37),
(39, '2024-06-22', '13:00', "Public Policy Analysis", 37),

-- Anthropology Department
(40, '2024-06-15', '11:00', "Cultural Anthropology", 40),
(41, '2024-06-23', '15:00', "Archaeology", 39),
(42, '2024-06-21', '13:00', "Biological Anthropology", 40),

-- Economics Department
(43, '2024-06-17', '11:00', "Microeconomics", 42),
(44, '2024-06-24', '09:00', "Macroeconomics", 42),
(45, '2024-06-22', '15:00', "Econometrics", 42),

-- Painting Department
(46, '2024-06-16', '13:00', "Oil Painting", 45),
(47, '2024-06-24', '09:00', "Watercolor Techniques", 44),
(48, '2024-06-22', '15:00', "Portrait Drawing", 45),

-- Sculpture Department
(49, '2024-06-17', '11:00', "Stone Carving", 47),
(50, '2024-06-23', '13:00', "Metal Sculpture", 48),
(51, '2024-06-21', '10:00', "Ceramics", 48),

-- Photography Department
(52, '2024-06-18', '15:00', "Digital Photography", 50),
(53, '2024-06-24', '13:00', "Darkroom Techniques", 50),
(54, '2024-06-22', '09:00', "Photographic Composition", 50),

-- Graphic Design Department
(55, '2024-06-15', '13:00', "Typography", 52),
(56, '2024-06-23', '11:00', "Brand Identity Design", 52),
(57, '2024-06-21', '09:00', "Printmaking", 52),

-- Art History Department
(58, '2024-06-17', '13:00', "Renaissance Art", 54),
(59, '2024-06-24', '15:00', "Modern Art", 54),
(60, '2024-06-22', '11:00', "Asian Art History", 54),

-- Computer Science Department
(61, '2024-06-16', '09:00', "Algorithm Design", 56),
(62, '2024-06-23', '15:00', "Database Systems", 56),
(63, '2024-06-21', '11:00', "Web Development", 56),

-- Software Engineering Department
(64, '2024-06-17', '15:00', "Software Testing", 59),
(65, '2024-06-24', '11:00', "Agile Software Development", 59),
(66, '2024-06-22', '13:00', "Mobile Application Development", 58),

-- Information Systems Department
(67, '2024-06-16', '13:00', "Database Management", 61),
(68, '2024-06-23', '11:00', "Enterprise Systems", 61),
(69, '2024-06-21', '09:00', "Information Security", 61),

-- Cyber Security Department
(70, '2024-06-17', '13:00', "Cyber Threat Intelligence", 63),
(71, '2024-06-24', '15:00', "Ethical Hacking", 63),
(72, '2024-06-22', '09:00', "Digital Forensics", 64),

-- Data Science Department
(73, '2024-06-15', '11:00', "Data Mining", 66),
(74, '2024-06-23', '13:00', "Machine Learning", 66),
(75, '2024-06-21', '09:00', "Big Data Analytics", 66),

-- Nursing Department
(76, '2024-06-16', '15:00', "Medical-Surgical Nursing", 68),
(77, '2024-06-23', '09:00', "Pediatric Nursing", 69),
(78, '2024-06-21', '13:00', "Mental Health Nursing", 69),

-- Public Health Department
(79, '2024-06-17', '09:00', "Epidemiology", 72),
(80, '2024-06-24', '15:00', "Health Policy", 72),
(81, '2024-06-22', '11:00', "Community Health", 71),

-- Physical Therapy Department
(82, '2024-06-15', '13:00', "Orthopedic Physical Therapy", 74),
(83, '2024-06-23', '11:00', "Neurological Physical Therapy", 74),
(84, '2024-06-21', '09:00', "Geriatric Physical Therapy", 74),

-- Occupational Therapy Department
(85, '2024-06-16', '09:00', "Hand Therapy", 77),
(86, '2024-06-23', '15:00', "Pediatric Occupational Therapy", 76),
(87, '2024-06-21', '13:00', "Mental Health Occupational Therapy", 76),

-- Nutrition and Dietetics Department
(88, '2024-06-17', '15:00', "Clinical Nutrition", 79),
(89, '2024-06-24', '11:00', "Sports Nutrition", 80),
(90, '2024-06-22', '13:00', "Community Nutrition", 80);