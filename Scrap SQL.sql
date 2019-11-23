/*
	SCRAP.SQL
	09/13/2018
*/

create table Users 
(
	userID int identity(1,1) primary key, 
	fName varchar(50) not null,
	lName varchar(50) not null,
	email varchar(200) not null unique,
	pwd varchar(50) not null,
	phone varchar(10) not null,
	lat float,
	lon float 

)

insert into Users 
(fname, lname, email, pwd, phone)
select 'George', 'Smith', 'funny@hat.com', '9998tt1', '8887776666';

insert into Users 
(fname, lname, email, pwd, phone)
select 'Jelly', 'Bone', 'happy@hat.com', '221T3', '5554889112';

select * from Users
where email like 'fun%'

create table UserLogins
(
	logInID int identity(1,1) primary key,
	userID int foreign key references Users(userID),
	logInDateTime datetime not null default(getdate()),
	lat float,
	lon float
)

select * from Users

insert into UserLogins
(userID)
select 2

insert into UserLogins
(userID)
select 1

insert into UserLogins
(userID)
select 2

insert into UserLogins
(userID)
select 1



select u.userID, lName, fName, logInDateTime from UserLogins ul
join Users u on u.userID = ul.userID
order by logInDateTime

create table Manufacturers
(
	manID int identity(1,1) primary key,
	manName varchar(100) not null
)

insert into Manufacturers
(manName)
select 'Apple'

insert into Manufacturers
(manName)
select 'IBM'

insert into Manufacturers
(manName)
select 'Microsoft'

insert into Manufacturers
(manName)
select 'Lenovo'

select * from Manufacturers

create table Models
(
	modelID int identity(1,1) primary key,
	modelName varchar(100) not null unique
)

create table Parts
(
	partsID int identity(1,1) primary key,
	manID int foreign key references Manufacturers(manID),
	modelId int foreign key references Models(modelID),
	partNum varchar(100) not null,
	partDesc varchar(8000),
	partPic varchar(200)
)

insert into Models
(modelName)
select 'stuff'

insert into Models
(modelName)
select'IPhone'

insert into Models
(modelName)
select'Mac Book Pro'

select * from Models

insert into Parts
(partNum, modelId, manID, partDesc)
select '292929', '1', '2', 'The fun product'

select * from Parts

create table OfferStat
(
	statusID int identity(1,1) primary key,
	statDes varchar(25) not null
)

insert into OfferStat(statDes)
select 'open'

insert into OfferStat(statDes)
select 'close'

create table Offers 
(
	offerID int identity(1,1) primary key,
	sellerID int foreign key references Users(userID),
	partsID int foreign key references Parts(partsID),
	offerDate datetime not null default(getdate()),
	ostat int foreign key references OfferStat(statusID) default(1),
	price money not null default(0.00)

)


create table Transactions
(
	tranId int identity(1,1) primary key,
	offerID int foreign key references Offers(offerID),
	buyerID int foreign key references Users(userID),
	tranDate datetime not null default(getDate()),
	salePrice money not null default(0.00)
)


select * from Parts

insert into Offers(sellerID, partsID, price)
select 1, 1, 200.00

select * from Offers


insert into Transactions(offerID, buyerId, salePrice)
select 1, 2, 150.00

select * from Transactions

insert into Offers(sellerID, partsID, price)
select 2, 1, 400.00

insert into Transactions(offerID, buyerId, salePrice)
select 2, 1, 300.00


-- tranDate, seller, buyer, partDesc, modelDesc, offerPrice, salePrice
select t.tranDate, u.lName Seller, us.lName Buyer, p.partDesc Part, m.modelName 
Model , o.price, t.salePrice from Transactions t
join Offers o on o.offerId = t.offerID
join Users u on u.userID = o.sellerID
join Users us on us.userID = t.buyerID
join Parts p on p.partsID = o.partsId
join Models m on m.modelID = p.modelId
