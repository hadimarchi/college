Name: Hal DiMarchi

Problems 1.12, 1.13, 2.12

##### 1.12:
**Question:** Cite some examples of integrity constraints that can apply to the database in figure 1.2

**Answer:**
  - Student table
    - Name element constrained to varchar type
    - Number element constrained to a number
    - Number element is unique
  - Course table
    - Course name is unique
    - Course number is unique
  - Section table
    - Each section record must reference a course record
    - Semester element limited to a type with [fall, spring, summer] valid values
    - Section identifier must be unique
  - Grade Report
    - Each grade record must reference a student record
    - Grades limited to a type with [I, F, D, C, B, A] valid values
  - Prerequisites
    - Each record must reference a course record

##### 1.13:
** Question: ** Give some examples of systems in which use of traditional file processing may make more sense than a database approach.

** Answer: **
  - Systems in which the data we are using is simple and limited in its relationships
    - A contacts list with just names, phone numbers, and emails
  - Systems without multiple user access
    - a log file for an application running
      without user interaction
    - A list of books I've read
    - Journal entries


##### 2.12:
** Question: ** Think of different users for the database shown in Figure 1.2. What types of
applications would each user need? To which user category would each belong, and what type of interface would each need?

** Answer: **
  - Database superuser
    - DBA Staff
    - access to DDL and DML compilers with full privileges
    - interface is likely a command line, perhaps with a gui visualization of the database at the conceptual level

  - Casual Users

    - School Administrator
      - A casual superuser
      - Read access across database
      - Write access across database

    - Teacher
      - Read access across database
      - Write access to grade report
      - Write access to prerequisites

    - Student
      - Read access to their student record and grade report record
      - Read access to courses, prerequisites, and sections

    - ** Shared Application(s) **
      - Menu based web-client
      - Keyword based search
      - Mobile App
      - Form based interface
      - GUI


  - Mobile app developer
    - Application programmer user
    - Needs an API on a network for the database
      - DML compiler in API backend
    - Privileges up to those available in application
