INSERT INTO Department VALUES ('D01', '컴퓨터공학과', 'B101', NULL);
INSERT INTO Department VALUES ('D02', '소프트웨어학과', 'B102', NULL);
INSERT INTO Department VALUES ('D03', '정보보호학과', 'B201', NULL);
INSERT INTO Department VALUES ('D04', '인공지능학과', 'B202', NULL);
INSERT INTO Department VALUES ('D05', '데이터사이언스학과', 'B301', NULL);

INSERT INTO Professor VALUES ('P01', '김철수', '부산', '010-1111-1111', 'C101', '컴퓨터구조', 'D01');
INSERT INTO Professor VALUES ('P02', '이영희', '서울', '010-2222-2222', 'C102', '운영체제', 'D02');
INSERT INTO Professor VALUES ('P03', '박민수', '대구', '010-3333-3333', 'C201', '정보보호', 'D03');
INSERT INTO Professor VALUES ('P04', '최지현', '광주', '010-4444-4444', 'C202', 'AI', 'D04');
INSERT INTO Professor VALUES ('P05', '정우성', '부산', '010-5555-5555', 'C301', '데이터마이닝', 'D05');

INSERT INTO Assistant VALUES ('A01', '김조교', '부산', '010-1234-1111', 'D01');
INSERT INTO Assistant VALUES ('A02', '이조교', '부산', '010-1234-2222', 'D02');
INSERT INTO Assistant VALUES ('A03', '박조교', '부산', '010-1234-3333', 'D03');
INSERT INTO Assistant VALUES ('A04', '최조교', '부산', '010-1234-4444', 'D04');
INSERT INTO Assistant VALUES ('A05', '정조교', '부산', '010-1234-5555', 'D05');

INSERT INTO Student VALUES ('S01', '학생1', '부산', '010-2000-0001', '학부', 'D01');
INSERT INTO Student VALUES ('S02', '학생2', '부산', '010-2000-0002', '학부', 'D02');
INSERT INTO Student VALUES ('S03', '학생3', '부산', '010-2000-0003', '학부', 'D03');
INSERT INTO Student VALUES ('S04', '학생4', '부산', '010-2000-0004', '석사', 'D04');
INSERT INTO Student VALUES ('S05', '학생5', '부산', '010-2000-0005', '박사', 'D05');
INSERT INTO Student VALUES ('S06', '학생6', '부산', '010-2000-0006', '학부', 'D01');
INSERT INTO Student VALUES ('S07', '학생7', '부산', '010-2000-0007', '학부', 'D02');
INSERT INTO Student VALUES ('S08', '학생8', '부산', '010-2000-0008', '석사', 'D03');
INSERT INTO Student VALUES ('S09', '학생9', '부산', '010-2000-0009', '박사', 'D04');
INSERT INTO Student VALUES ('S10', '학생10', '부산', '010-2000-0010', '학부', 'D05');

INSERT INTO Course VALUES ('C01', '데이터베이스', 3, 'A01');
INSERT INTO Course VALUES ('C02', '운영체제', 3, 'A02');
INSERT INTO Course VALUES ('C03', '네트워크', 3, 'A03');
INSERT INTO Course VALUES ('C04', '인공지능', 3, 'A04');

INSERT INTO Classroom VALUES ('R01', '공학관', 1, 101, 60);
INSERT INTO Classroom VALUES ('R02', '공학관', 2, 201, 60);
INSERT INTO Classroom VALUES ('R03', '공학관', 3, 301, 60);
INSERT INTO Classroom VALUES ('R04', '공학관', 4, 401, 60);

INSERT INTO Lecture VALUES ('L01', 'P01', 'C01', 'R01');
INSERT INTO Lecture VALUES ('L02', 'P02', 'C02', 'R02');
INSERT INTO Lecture VALUES ('L03', 'P03', 'C03', 'R03');
INSERT INTO Lecture VALUES ('L04', 'P04', 'C04', 'R04');
INSERT INTO Lecture VALUES ('L05', 'P05', 'C01', 'R01');
INSERT INTO Lecture VALUES ('L06', 'P01', 'C02', 'R02');
INSERT INTO Lecture VALUES ('L07', 'P03', 'C03', 'R03');
INSERT INTO Lecture VALUES ('L08', 'P05', 'C04', 'R04');

-- L01
INSERT INTO Enrollment VALUES ('S01', 'L01', 'A');
INSERT INTO Enrollment VALUES ('S02', 'L01', 'B');
INSERT INTO Enrollment VALUES ('S03', 'L01', 'A');
INSERT INTO Enrollment VALUES ('S04', 'L01', 'B');
INSERT INTO Enrollment VALUES ('S05', 'L01', 'A');

-- L02
INSERT INTO Enrollment VALUES ('S06', 'L02', 'B');
INSERT INTO Enrollment VALUES ('S07', 'L02', 'A');
INSERT INTO Enrollment VALUES ('S08', 'L02', 'C');
INSERT INTO Enrollment VALUES ('S09', 'L02', 'B');
INSERT INTO Enrollment VALUES ('S10', 'L02', 'A');

-- L03
INSERT INTO Enrollment VALUES ('S01', 'L03', 'B');
INSERT INTO Enrollment VALUES ('S02', 'L03', 'A');
INSERT INTO Enrollment VALUES ('S03', 'L03', 'B');
INSERT INTO Enrollment VALUES ('S04', 'L03', 'C');
INSERT INTO Enrollment VALUES ('S05', 'L03', 'A');

-- L04
INSERT INTO Enrollment VALUES ('S06', 'L04', 'A');
INSERT INTO Enrollment VALUES ('S07', 'L04', 'B');
INSERT INTO Enrollment VALUES ('S08', 'L04', 'A');
INSERT INTO Enrollment VALUES ('S09', 'L04', 'B');
INSERT INTO Enrollment VALUES ('S10', 'L04', 'C');

-- L05
INSERT INTO Enrollment VALUES ('S01', 'L05', 'A');
INSERT INTO Enrollment VALUES ('S02', 'L05', 'B');
INSERT INTO Enrollment VALUES ('S03', 'L05', 'C');
INSERT INTO Enrollment VALUES ('S04', 'L05', 'A');
INSERT INTO Enrollment VALUES ('S05', 'L05', 'B');

-- L06
INSERT INTO Enrollment VALUES ('S06', 'L06', 'C');
INSERT INTO Enrollment VALUES ('S07', 'L06', 'B');
INSERT INTO Enrollment VALUES ('S08', 'L06', 'A');
INSERT INTO Enrollment VALUES ('S09', 'L06', 'C');
INSERT INTO Enrollment VALUES ('S10', 'L06', 'B');

-- L07
INSERT INTO Enrollment VALUES ('S01', 'L07', 'B');
INSERT INTO Enrollment VALUES ('S02', 'L07', 'C');
INSERT INTO Enrollment VALUES ('S03', 'L07', 'A');
INSERT INTO Enrollment VALUES ('S04', 'L07', 'B');
INSERT INTO Enrollment VALUES ('S05', 'L07', 'A');

-- L08
INSERT INTO Enrollment VALUES ('S06', 'L08', 'A');
INSERT INTO Enrollment VALUES ('S07', 'L08', 'B');
INSERT INTO Enrollment VALUES ('S08', 'L08', 'C');
INSERT INTO Enrollment VALUES ('S09', 'L08', 'A');
INSERT INTO Enrollment VALUES ('S10', 'L08', 'B');
