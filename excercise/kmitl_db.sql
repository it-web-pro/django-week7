-- -------------------------------------------------------------
-- TablePlus 6.6.8(632)
--
-- https://tableplus.com/
--
-- Database: kmitl
-- Generation Time: 2568-08-09 00:29:42.8040
-- -------------------------------------------------------------


INSERT INTO "public"."registration_faculty" ("id", "name", "code") VALUES
(1, 'Faculty of Engineering', '01'),
(2, 'Faculty of Information Technology', '07'),
(3, 'Faculty of Science', '05');

INSERT INTO "public"."registration_professor" ("id", "first_name", "last_name", "faculty_id") VALUES
(1, 'John', 'Smith', 1),
(2, 'Mary', 'Jane', 1),
(3, 'Peter', 'Jones', 2),
(4, 'Susan', 'Miller', 2),
(5, 'David', 'Wilson', 3),
(6, 'Linda', 'Garcia', 3);

INSERT INTO "public"."registration_course" ("id", "course_code", "course_name", "credits") VALUES
(1, '01006011', 'General Chemistry', 3),
(2, '04006001', 'Calculus I', 3),
(3, '01076001', 'Computer Programming', 3),
(4, '01076113', 'Data Structures and Algorithms', 3),
(5, '01076032', 'Digital Circuit and Logic Design', 3),
(6, '06016301', 'Introduction to Information Technology', 3),
(7, '06016311', 'Object-Oriented Programming', 3),
(8, '04006002', 'Calculus II', 3),
(9, '04026001', 'General Physics I', 3),
(10, '01076114', 'Database Systems', 3);

INSERT INTO "public"."registration_section" ("id", "section_number", "semester", "day_of_week", "start_time", "end_time", "capacity", "course_id", "professor_id") VALUES
(1, '101', '1/2568', 'MON', '09:00:00', '12:00:00', 60, 1, 5),
(2, '101', '1/2568', 'TUE', '09:00:00', '12:00:00', 70, 2, 6),
(3, '102', '1/2568', 'THU', '13:00:00', '16:00:00', 70, 2, 6),
(4, '101', '1/2568', 'WED', '13:00:00', '16:00:00', 50, 3, 1),
(5, '101', '1/2568', 'FRI', '09:00:00', '12:00:00', 50, 5, 2),
(6, '101', '1/2568', 'MON', '13:00:00', '16:00:00', 60, 9, 5),
(7, '201', '1/2568', 'MON', '09:00:00', '12:00:00', 80, 6, 3),
(8, '201', '1/2568', 'TUE', '13:00:00', '16:00:00', 80, 7, 4),
(9, '202', '1/2568', 'FRI', '09:00:00', '12:00:00', 80, 7, 4),
(10, '201', '1/2568', 'WED', '09:00:00', '12:00:00', 60, 4, 3),
(11, '201', '1/2568', 'THU', '09:00:00', '12:00:00', 60, 10, 4);

INSERT INTO "public"."registration_student" ("id", "student_id", "first_name", "last_name", "faculty_id") VALUES
(1, '67010111', 'Somchai', 'Lertprasert', 1),
(2, '67010112', 'Areeya', 'Charoensuk', 1),
(3, '67070221', 'Anucha', 'Saetang', 2),
(4, '67070222', 'Pornthip', 'Wongsuwan', 2),
(5, '66010331', 'Preecha', 'Boonmee', 1),
(6, '66010332', 'Sunee', 'Kittipong', 1),
(7, '66070441', 'Thanakorn', 'Sae-lim', 2),
(8, '66070442', 'Kanokwan', 'Promsorn', 2),
(9, '65010551', 'Chatchai', 'Ratanaporn', 1),
(10, '65070661', 'Siriporn', 'Jirawat', 2),
(11, '67011001', 'Nattapong', 'Phromma', 1),
(12, '67011002', 'Jiraporn', 'Sae-heng', 1),
(13, '67072101', 'Apisit', 'Chaiyo', 2),
(14, '67072102', 'Waraporn', 'Srisuk', 2),
(15, '66050123', 'Wichai', 'Sangthong', 3),
(16, '67050456', 'Kanjana', 'Saeli', 3),
(17, '67011234', 'Ekkachai', 'Sribut', 1),
(18, '67074321', 'Chutima', 'Boonruang', 2),
(19, '66017890', 'Sakda', 'Ngamdee', 1),
(20, '66079876', 'Wanna', 'Jaroen', 2);

INSERT INTO "public"."registration_student_enrolled_sections" ("id", "student_id", "section_id") VALUES
(50, 1, 2),
(51, 1, 4),
(52, 1, 6),
(53, 2, 2),
(54, 2, 5),
(55, 2, 6),
(56, 5, 1),
(57, 5, 3),
(58, 5, 5),
(59, 6, 1),
(60, 6, 3),
(61, 6, 4),
(62, 9, 1),
(63, 9, 2),
(64, 11, 1),
(65, 11, 4),
(66, 11, 6),
(67, 12, 2),
(68, 12, 5),
(69, 12, 6),
(70, 17, 3),
(71, 17, 4),
(72, 19, 1),
(73, 19, 5),
(74, 3, 7),
(75, 3, 8),
(76, 3, 10),
(77, 4, 7),
(78, 4, 9),
(79, 4, 11),
(80, 7, 7),
(81, 7, 8),
(82, 7, 11),
(83, 8, 7),
(84, 8, 9),
(85, 8, 10),
(86, 10, 7),
(87, 10, 8),
(88, 13, 7),
(89, 13, 10),
(90, 13, 11),
(91, 14, 7),
(92, 14, 9),
(93, 18, 8),
(94, 18, 10),
(95, 18, 11),
(96, 20, 7),
(97, 20, 9),
(98, 20, 11);

INSERT INTO "public"."registration_studentprofile" ("student_id", "email", "phone_number", "address") VALUES
(1, '67010111@kmitl.ac.th', '081-111-1111', '123 Rama IV Rd, Bangkok'),
(2, '67010112@kmitl.ac.th', '081-222-2222', '456 Sukhumvit Rd, Bangkok'),
(3, '67070221@kmitl.ac.th', '081-333-3333', '789 Silom Rd, Bangkok'),
(4, '67070222@kmitl.ac.th', '081-444-4444', '101 Phayathai Rd, Bangkok'),
(5, '66010331@kmitl.ac.th', '081-555-5555', '212 Ratchadaphisek Rd, Bangkok'),
(6, '66010332@kmitl.ac.th', '081-666-6666', '333 Ladprao Rd, Bangkok'),
(7, '66070441@kmitl.ac.th', '081-777-7777', '444 Phetkasem Rd, Bangkok'),
(8, '66070442@kmitl.ac.th', '081-888-8888', '555 Vibhavadi Rangsit Rd, Bangkok'),
(9, '65010551@kmitl.ac.th', '081-999-9999', '666 Ramkhamhaeng Rd, Bangkok'),
(10, '65070661@kmitl.ac.th', '081-000-0000', '777 Chaengwattana Rd, Bangkok'),
(11, '67011001@kmitl.ac.th', '082-111-1111', '111 Main St, Bangkok'),
(12, '67011002@kmitl.ac.th', '082-222-2222', '222 Park Ave, Bangkok'),
(13, '67072101@kmitl.ac.th', '082-333-3333', '333 Elm St, Bangkok'),
(14, '67072102@kmitl.ac.th', '082-444-4444', '444 Oak St, Bangkok'),
(15, '66050123@kmitl.ac.th', '082-555-5555', '555 Pine St, Bangkok'),
(16, '67050456@kmitl.ac.th', '082-666-6666', '666 Maple St, Bangkok'),
(17, '67011234@kmitl.ac.th', '082-777-7777', '777 Birch St, Bangkok'),
(18, '67074321@kmitl.ac.th', '082-888-8888', '888 Cedar St, Bangkok'),
(19, '66017890@kmitl.ac.th', '082-999-9999', '999 Walnut St, Bangkok'),
(20, '66079876@kmitl.ac.th', '082-000-0000', '100 Cherry St, Bangkok');

