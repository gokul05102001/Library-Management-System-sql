CREATE DATABASE Library;

USE Library;
CREATE TABLE Branch(
	Branch_no INT PRIMARY KEY,
	Manager_Id  INT ,
	Branch_address  VARCHAR(200),
	Contact_no varchar(20)
    );

CREATE TABLE Employee (
	Emp_Id INT PRIMARY KEY ,
	Emp_name  VARCHAR(50),
	Position VARCHAR(50),
	Salary DECIMAL(10,2),
	Branch_no INT,
    foreign key (Branch_no) references Branch(Branch_no)
    );
 CREATE TABLE Books(
	ISBN VARCHAR(50) PRIMARY KEY ,
	Book_title  VARCHAR(50),
	Category  VARCHAR(50),
	Rental_Price DECIMAL(10,2),
	Status VARCHAR(3),  
	Author  VARCHAR(50),
	Publisher VARCHAR(50)
    );
CREATE TABLE Customer (
	Customer_Id INT PRIMARY KEY ,
	Customer_name  VARCHAR(50),
	Customer_address  VARCHAR(100),
	Reg_date DATE
    );
CREATE TABLE IssueStatus (
	Issue_Id INT PRIMARY KEY ,
	Issued_cust INT,
    Issued_book_name VARCHAR(50),
	Issue_date 	DATE,
    Isbn_book VARCHAR(50),
    FOREIGN KEY(Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
    );
    
CREATE TABLE ReturnStatus (
	Return_Id INT PRIMARY KEY ,
	Return_cust VARCHAR(50), 
	Return_book_name  VARCHAR(50),
	Return_date DATE, 
	Isbn_book2 VARCHAR(50),
	FOREIGN KEY (Isbn_book2)REFERENCES Books(ISBN)
    );

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, 'Main St, Cityville', '9744009877'),
(2, 102, 'Elm St, Townsville', '8765432780'),
(3, 103, 'Maple Ave, Villageville', '8976543267');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'John Doe', 'Manager', 60000, 1),
(102, 'Jane Smith', 'Manager', 62000, 2),
(103, 'Bob Johnson', 'Manager', 58000, 3),
(104, 'Alice Brown', 'Librarian', 45000, 1),
(105, 'Charlie Davis', 'Assistant Librarian', 40000, 1),
(106, 'Eve Clark', 'Librarian', 47000, 2),
(107, 'Frank Martin', 'Assistant Librarian', 39000, 2),
(108, 'Grace Lee', 'Librarian', 44000, 3);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-0-123456-47-2', 'Introduction to Algorithms', 'Technology', 30.00, 'Yes', 'Thomas H. Cormen', 'MIT Press'),
('978-0-987654-32-1', 'History of World War II', 'History', 25.00, 'No', 'John Keegan', 'Penguin Books'),
('978-1-234567-89-0', 'The Art of Computer Programming', 'Technology', 35.00, 'Yes', 'Donald Knuth', 'Addison-Wesley'),
('978-0-111111-22-2', 'Moby Dick', 'Fiction', 20.00, 'Yes', 'Herman Melville', 'Harper & Brothers'),
('978-0-222222-33-3', 'Pride and Prejudice', 'Fiction', 18.00, 'No', 'Jane Austen', 'T. Egerton'),
('978-0-333333-44-4', 'The Brief History of Time', 'Science', 28.00, 'Yes', 'Stephen Hawking', 'Bantam Books'),
('978-0-444444-55-5', '1984', 'Fiction', 22.00, 'Yes', 'George Orwell', 'Secker & Warburg'),
('978-0-555555-66-6', 'The History of the Ancient World', 'History', 24.00, 'Yes', 'Susan Wise Bauer', 'W.W. Norton & Company');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(201, 'Michael Johnson', '789 Pine St, Cityville', '2021-12-15'),
(202, 'Emily Clark', '654 Oak St, Townsville', '2022-01-20'),
(203, 'Daniel Lewis', '321 Cedar St, Villageville', '2023-03-10'),
(204, 'Sophia Turner', '987 Birch Ave, Cityville', '2021-11-30'),
(205, 'James Wilson', '432 Spruce Rd, Townsville', '2022-06-25'),
(206, 'Olivia Martinez', '345 Walnut St, Villageville', '2023-05-15');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(301, 201, 'The Brief History of Time', '2023-06-10', '978-0-333333-44-4'),
(302, 202, '1984', '2023-06-12', '978-0-444444-55-5'),
(303, 203, 'Moby Dick', '2023-07-01', '978-0-111111-22-2'),
(304, 204, 'Introduction to Algorithms', '2023-07-15', '978-0-123456-47-2');


INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(401, 201, 'The Brief History of Time', '2023-06-20', '978-0-333333-44-4'),
(402, 202, '1984', '2023-06-22', '978-0-444444-55-5');
SELECT * FROM Branch;
SELECT * FROM BOOKS;
SELECT * FROM IssueStatus;
SELECT * FROM Customer;
SELECT * FROM ReturnStatus;
## 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'Yes';

## 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

## 3. Retrieve the book titles and the corresponding customers who have issued those books
SELECT B.Book_title, C.Customer_name FROM Books B JOIN IssueStatus I ON B.ISBN = I.Isbn_book
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

## 4. Display the total count of books in each category. 
SELECT Category, COUNT(*) AS Book_Count FROM Books GROUP BY Category;

## 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 

SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

## 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT C.Customer_name FROM Customer C LEFT JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE C.Reg_date < '2022-01-01' AND I.Issue_Id IS NULL;

## 7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no;

## 8. Display the names of customers who have issued books in the month of June 2023.
SELECT c.Customer_name FROM Customer c JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

##  9. Retrieve book_title from book table containing history. 
SELECT Book_title FROM Books WHERE Book_title LIKE '%history%';

## 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Employee_Count FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;

## 11. Retrieve the names of employees who manage branches and their respective branch addresses
SELECT E.Emp_name, B.Branch_address FROM Employee E JOIN Branch B ON E.Emp_Id = B.Manager_Id;

## 12..  Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT DISTINCT C.Customer_name FROM Customer C JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN WHERE B.Rental_Price > 25;







