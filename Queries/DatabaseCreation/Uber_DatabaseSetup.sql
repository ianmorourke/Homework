create table uberMockUp.dbo.Vehicle
(
	vehicleID int IDENTITY(1,1) PRIMARY KEY,
	vehicleAlias varchar(15),
	makeID int,
	modelID int,
	modelYear int,
	Created DATETIME
)

create table uberMockUp.dbo.tbl_VehicleActivity
(
	activityID int IDENTITY(1,1) PRIMARY KEY,
	ActivityName VARCHAR(20)
)

create table uberMockUp.dbo.tbl_software
(
	softwareID int IDENTITY(1,1) PRIMARY KEY,
	softwareName VARCHAR(20)
)

create table uberMockUp.dbo.vehicleUser
(
	userID int IDENTITY(1,1) PRIMARY KEY,
	username VARCHAR(50),
	userEmail VARCHAR(100),
	firstName VARCHAR(50),
	lastName VARCHAR(50),
	userTeam int FOREIGN KEY REFERENCES tbl_team(teamID)
)

create table uberMockUp.dbo.tbl_team
(
	teamID int IDENTITY(1,1) PRIMARY KEY,
	teamName VARCHAR(20)
)

create table uberMockUp.dbo.VehicleActivityLog
(
	vehicleActivitylogID int IDENTITY(1,1)  PRIMARY KEY,
	vehicleID int FOREIGN KEY REFERENCES Vehicle(VehicleID),
	activityID int FOREIGN KEY REFERENCES tbl_vehicleActivity(activityID),
	startDate DATETIME,
	endDate DATETIME,
	softwareID int FOREIGN KEY REFERENCES tbl_software(softwareID),
	userID int FOREIGN KEY REFERENCES vehicleUser(userID)
)

create table ubermockup.dbo.pythonSampleProductsLog
(
	pythonLogID int IDENTITY(1,1) PRIMARY KEY,
	productID int,
	costPerMinute DECIMAL,
	Created DATETIME
)


insert into uberMockUp.dbo.tbl_software
(
	softwareName
)
select DISTINCT(software)
from uber.dbo.vehicletestdata

insert into uberMockUp.dbo.tbl_team
(
	teamName
)
select DISTINCT(team_name)
from uber.dbo.vehicletestdata

insert into uberMockUp.dbo.tbl_VehicleActivity
(
	ActivityName
)
select DISTINCT(vehicle_activity)
from uber.dbo.vehicletestdata

insert into ubermockup.dbo.Vehicle
(
	vehicleAlias,
	makeID,
	modelID,
	modelYear,
	created
)
select distinct(vehicle_alias), null, null, null, GETDATE()
from uber.dbo.vehicletestdata

insert into ubermockup.dbo.vehicleUser
(
	username,
	useremail,
	firstname,
	lastname,
	userteam
)
select distinct(v1.user_name), 
	null, 
	null, 
	null, 
	(
		select teamID 
		FROM ubermockup.dbo.tbl_team 
		WHERE teamName = 
			(
			select team_name
			from
				(
					select ROW_NUMBER() OVER(PARTITION BY user_name ORDER BY end_time desc) RN, user_name, team_name
					from uber.dbo.vehicletestdata
				) A
			WHERE a.rn = 1
			AND A.user_name = v1.user_name
			)
	)
from uber.dbo.vehicletestdata v1

--Verifying inserted values
select *
from ubermockup.dbo.tbl_software

select *
from ubermockup.dbo.tbl_team

select *
from ubermockup.dbo.tbl_vehicleactivity