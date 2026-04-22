CREATE TABLE User (
    userID INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    contactNo VARCHAR(20)
);

CREATE TABLE Meter (
    meterID INT PRIMARY KEY,
    installDate DATE,
    location VARCHAR(255),
    userID INT,
    FOREIGN KEY (userID) REFERENCES User(userID)
);

CREATE TABLE UsageData (
    kWhUsage VARCHAR(20) PRIMARY KEY,
    electricConsumption VARCHAR(100),
    timeStamp TIMESTAMP,
    meterID INT,
    FOREIGN KEY (meterID) REFERENCES Meter(meterID)
);

CREATE TABLE BillingInfo (
    invoiceNo INT PRIMARY KEY,
    amountDue DOUBLE,
    dueDate DATE,
    paymentMethod VARCHAR(50),
    meterID INT,
    userID INT,
    kwhUsage VARCHAR(20),
    FOREIGN KEY (meterID) REFERENCES Meter(meterID),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (kwhUsage) REFERENCES UsageData(kWhUsage)
);

CREATE TABLE PaymentTransaction (
    transactionID INT PRIMARY KEY,
    amount DOUBLE,
    date DATE,
    paymentStatus VARCHAR(20),
    invoiceNo INT,
    FOREIGN KEY (invoiceNo) REFERENCES BillingInfo(invoiceNo)
);

CREATE TABLE Receipt (
    userID INT,
    invoiceNo INT,
    transactionID INT,
    paymentStatus VARCHAR(20),
    amountDue DOUBLE,
    PRIMARY KEY (userID, invoiceNo),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (invoiceNo) REFERENCES BillingInfo(invoiceNo),
    FOREIGN KEY (transactionID) REFERENCES PaymentTransaction(transactionID)
);