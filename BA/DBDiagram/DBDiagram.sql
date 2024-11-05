CREATE TABLE [CUSTOMER] (
	[customer_id] CHAR NOT NULL UNIQUE,
	[customer_name] NVARCHAR,
	[phone_number] CHAR,
	[email] CHAR,
	[id_number] CHAR,
	[gender] CHAR,
	PRIMARY KEY([customer_id])
);
GO

CREATE TABLE [MEMBER_CARD] (
	[card_id] CHAR NOT NULL UNIQUE,
	[card_type] CHAR,
	[points] SMALLINT,
	[total_speding] INTEGER,
	[created_date] DATE,
	[rank_reached_date] DATE,
	[customer_member_id] CHAR,
	PRIMARY KEY([card_id])
);
GO

CREATE TABLE [RECEIPT] (
	[receipt_id] CHAR NOT NULL UNIQUE,
	[total] INTEGER,
	[discounted] INTEGER,
	[spending] INTEGER,
	[receipt_card_id] CHAR,
	PRIMARY KEY([receipt_id])
);
GO

CREATE TABLE [RATING] (
	[rating_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[serving_score] FLOAT,
	[branch_score] FLOAT,
	[food_score] FLOAT,
	[space_score] FLOAT,
	[rating_receipt_id] CHAR UNIQUE,
	PRIMARY KEY([rating_id])
);
GO

CREATE TABLE [DEPARTMENT] (
	[department_name] NVARCHAR UNIQUE,
	[deparment_branch_id] TINYINT,
	[department_id] TINYINT NOT NULL IDENTITY UNIQUE,
	PRIMARY KEY([department_id])
);
GO

CREATE TABLE [STAFF] (
	[staff_id] CHAR NOT NULL UNIQUE,
	[staff_name] NVARCHAR,
	[birthday] DATE,
	[gender] CHAR,
	[absent_enable_per_month] TINYINT,
	[address] NVARCHAR,
	[staff_department_id] TINYINT,
	[is_manager] BIT,
	PRIMARY KEY([staff_id])
);
GO

CREATE TABLE [RESERVATION] (
	[reservation_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[number_of_seat] TINYINT,
	[serving_date] DATE,
	[note] NVARCHAR,
	[staff_id] CHAR,
	[is_online] BIT,
	[customer_id] CHAR,
	PRIMARY KEY([reservation_id])
);
GO

CREATE TABLE [ORDER_DETAIL] (
	[detail_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[detail_food_id] TINYINT,
	[quantity] TINYINT,
	[detail_reservation_id] INTEGER,
	[detail_receipt_id] CHAR,
	PRIMARY KEY([detail_id])
);
GO

CREATE TABLE [REGION] (
	[region_id] TINYINT NOT NULL IDENTITY UNIQUE,
	[region_label] NVARCHAR,
	PRIMARY KEY([region_id])
);
GO

CREATE TABLE [BRANCH] (
	[branch_name] NVARCHAR UNIQUE,
	[address] NVARCHAR UNIQUE,
	[region_id] TINYINT,
	[open_hours] CHAR,
	[close_hour] CHAR,
	[car_parking_area] NVARCHAR,
	[motocycle_parking_area] NVARCHAR,
	[branch_id] TINYINT NOT NULL IDENTITY UNIQUE,
	PRIMARY KEY([branch_id])
);
GO

CREATE TABLE [MENU] (
	[menu_id] TINYINT NOT NULL IDENTITY UNIQUE,
	[menu_label] NVARCHAR,
	[menu_description] NVARCHAR,
	[branch_id] TINYINT,
	PRIMARY KEY([menu_id])
);
GO

CREATE TABLE [FOOD] (
	[food_id] TINYINT NOT NULL IDENTITY UNIQUE,
	[food_label] NVARCHAR,
	[price] FLOAT,
	[created_date] DATE,
	[food_menu_id] TINYINT,
	PRIMARY KEY([food_id])
);
GO

CREATE TABLE [SALARY] (
	[salary_id] INTEGER NOT NULL IDENTITY UNIQUE,
	[standard] FLOAT,
	[bonus] FLOAT,
	[deduction] FLOAT,
	[receive] FLOAT,
	[receive_date] DATE,
	[salary_staff_id] CHAR,
	PRIMARY KEY([salary_id])
);
GO

ALTER TABLE [CUSTOMER]
ADD FOREIGN KEY([customer_id]) REFERENCES [MEMBER_CARD]([customer_member_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [MEMBER_CARD]
ADD FOREIGN KEY([card_id]) REFERENCES [RECEIPT]([receipt_card_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [RECEIPT]
ADD FOREIGN KEY([receipt_id]) REFERENCES [RATING]([rating_receipt_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [STAFF]
ADD FOREIGN KEY([staff_id]) REFERENCES [RESERVATION]([staff_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [CUSTOMER]
ADD FOREIGN KEY([customer_id]) REFERENCES [RESERVATION]([customer_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [RESERVATION]
ADD FOREIGN KEY([reservation_id]) REFERENCES [ORDER_DETAIL]([detail_reservation_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [RECEIPT]
ADD FOREIGN KEY([receipt_id]) REFERENCES [ORDER_DETAIL]([detail_receipt_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [BRANCH]
ADD FOREIGN KEY([branch_id]) REFERENCES [MENU]([branch_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [REGION]
ADD FOREIGN KEY([region_id]) REFERENCES [BRANCH]([region_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [BRANCH]
ADD FOREIGN KEY([branch_id]) REFERENCES [DEPARTMENT]([deparment_branch_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [DEPARTMENT]
ADD FOREIGN KEY([department_id]) REFERENCES [STAFF]([staff_department_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [MENU]
ADD FOREIGN KEY([menu_id]) REFERENCES [FOOD]([food_menu_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [FOOD]
ADD FOREIGN KEY([food_id]) REFERENCES [ORDER_DETAIL]([detail_food_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [STAFF]
ADD FOREIGN KEY([staff_id]) REFERENCES [SALARY]([salary_staff_id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO