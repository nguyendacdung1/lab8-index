create database Aptech
go
use Aptech
go
-- tạo bảng Classes
create table Classes (
	ClassName char(6),
	Teacher varchar(30),
	TimeSlot varchar(30),
	Class int,
	Lab int
)
/*Tạo an unique, clustered index tên là MyClusteredIndex trên trường ClassName với thuộc tính sau:
Pad_index = on
FillFactor =70
Ignore_ Dup_Key=on*/
create unique clustered index MyClusteredIndex 
on Classes(ClassName) with (Pad_index = on, FillFactor = 70, Ignore_dup_key = on)
-- Tạo a nonclustered index tên là TeacherIndex trên trường Teacher
create nonclustered index TeacherIndex on Classes(Teacher)
-- Xóa chỉ mục TeacherIndex
drop index TeacherIndex on Classes
-- Tạo một composite index tên là ClassLabIndex trên 2 trường Class và Lab.
create index ClassLabIndex on Classes(Class, Lab)
-- Viết câu lệnh xem toàn bộ các chỉ mục của cơ sở dữ liệu Aptech.
SELECT DB_NAME() AS Database_Name
, sc.name AS Schema_Name
, o.name AS Table_Name
, i.name AS Index_Name
, i.type_desc AS Index_Type
FROM sys.indexes i
INNER JOIN sys.objects o ON i.object_id = o.object_id
INNER JOIN sys.schemas sc ON o.schema_id = sc.schema_id
WHERE i.name IS NOT NULL
AND o.type = 'U'
ORDER BY o.name, i.type