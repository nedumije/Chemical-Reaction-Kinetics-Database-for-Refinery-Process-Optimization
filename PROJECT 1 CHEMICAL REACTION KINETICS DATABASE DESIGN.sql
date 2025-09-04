-- Create the Chemical Reaction Kinetics Database
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ChemKineticsDB')
    DROP DATABASE ChemKineticsDB;
GO

CREATE DATABASE ChemKineticsDB;
GO

USE ChemKineticsDB;
GO

-- Table Creation (40 tables, reordered to respect foreign key dependencies)
-- Create tables without foreign keys first, then those with dependencies

-- Auxiliary Tables (10) - Create first as they are referenced by others
CREATE TABLE ReactionTypes (
    TypeID INT PRIMARY KEY IDENTITY(1,1),
    TypeName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    IsExothermic BIT NOT NULL DEFAULT 0,
    SafetyRating INT CHECK (SafetyRating BETWEEN 1 AND 5),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsActive BIT NOT NULL DEFAULT 1,
    StandardEnthalpy DECIMAL(10,2),
    ActivationEnergy DECIMAL(10,2),
    ReactionOrder DECIMAL(5,2),
    FrequencyFactor DECIMAL(10,2),
    DocumentationURL VARCHAR(200),
    ApprovalStatus VARCHAR(50),
    ReviewDate DATE,
    Notes TEXT,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    CategoryCode VARCHAR(20),
    LastValidatedDate DATE
);

CREATE TABLE ReactionStatus (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsActive BIT NOT NULL DEFAULT 1,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    StatusCategory VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    UsageFrequency INT DEFAULT 0,
    StatusCode VARCHAR(20),
    VisibilityLevel VARCHAR(50),
    CreatedByRole VARCHAR(50),
    Notes TEXT
);

CREATE TABLE ExperimentStatus (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsActive BIT NOT NULL DEFAULT 1,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    StatusCategory VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    UsageFrequency INT DEFAULT 0,
    StatusCode VARCHAR(20),
    VisibilityLevel VARCHAR(50),
    CreatedByRole VARCHAR(50),
    Notes TEXT
);

CREATE TABLE ParameterTypes (
    ParameterID INT PRIMARY KEY IDENTITY(1,1),
    ParameterName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ParameterCategory VARCHAR(50),
    IsCritical BIT NOT NULL DEFAULT 0,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    UsageFrequency INT DEFAULT 0,
    ParameterCode VARCHAR(20),
    ValidationNotes TEXT,
    StandardValue DECIMAL(10,2),
    DefaultUnit VARCHAR(20),
    PrecisionLevel DECIMAL(5,2),
    Notes TEXT
);

CREATE TABLE Units (
    UnitID INT PRIMARY KEY IDENTITY(1,1),
    UnitName VARCHAR(20) NOT NULL UNIQUE,
    Description TEXT,
    UnitType VARCHAR(50),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsStandard BIT NOT NULL DEFAULT 1,
    Precision DECIMAL(5,2),
    MinValue DECIMAL(10,2),
    MaxValue DECIMAL(10,2),
    ConversionBase VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    UnitCategory VARCHAR(50),
    DocumentationURL VARCHAR(200),
    UsageFrequency INT DEFAULT 0,
    Notes TEXT
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Contact VARCHAR(100),
    Address TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    SupplierRating INT CHECK (SupplierRating BETWEEN 1 AND 5),
    ContractStartDate DATE,
    ContractEndDate DATE,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    SupplierType VARCHAR(50),
    PaymentTerms VARCHAR(100),
    Notes TEXT
);

CREATE TABLE ReportTemplates (
    TemplateID INT PRIMARY KEY IDENTITY(1,1),
    TemplateName VARCHAR(100) NOT NULL,
    Description TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ReportType VARCHAR(50),
    IsActive BIT NOT NULL DEFAULT 1,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    TemplateCategory VARCHAR(50),
    UsageFrequency INT DEFAULT 0,
    TemplateCode VARCHAR(20),
    OutputFormat VARCHAR(50),
    Notes TEXT
);

CREATE TABLE DataSources (
    SourceID INT PRIMARY KEY IDENTITY(1,1),
    SourceName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    SourceType VARCHAR(50),
    IsActive BIT NOT NULL DEFAULT 1,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    SourceReliability INT CHECK (SourceReliability BETWEEN 1 AND 5),
    SourceOwner VARCHAR(100),
    SourceContact VARCHAR(100),
    UsageFrequency INT DEFAULT 0,
    SourceCode VARCHAR(20),
    Notes TEXT
);

CREATE TABLE Locations (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    RefineryName VARCHAR(100) NOT NULL,
    Site VARCHAR(100),
    Country VARCHAR(50),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    FacilityType VARCHAR(50),
    Capacity DECIMAL(10,2),
    OperationalStatus VARCHAR(50),
    ContactPerson VARCHAR(100),
    ContactEmail VARCHAR(100),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    Notes TEXT
);

CREATE TABLE Researchers (
    ResearcherID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Contact VARCHAR(100),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    EmployeeID VARCHAR(20) UNIQUE,
    ExpertiseArea VARCHAR(100),
    YearsExperience INT,
    Certification VARCHAR(100),
    SecurityClearance VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    OfficeLocation VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes TEXT
);

-- Core Tables (15) - Create after tables without dependencies
CREATE TABLE Reactions (
    ReactionID INT PRIMARY KEY IDENTITY(1,1),
    ReactionTypeID INT FOREIGN KEY REFERENCES ReactionTypes(TypeID),
    ReactionName VARCHAR(100) NOT NULL,
    Description TEXT,
    CreatedDate DATE DEFAULT GETDATE(),
    CreatedBy VARCHAR(100),
    ModifiedDate DATE,
    ModifiedBy VARCHAR(100),
    IsActive BIT NOT NULL DEFAULT 1,
    EquilibriumConstant DECIMAL(10,4),
    RateConstant DECIMAL(10,4),
    TemperatureRangeMin DECIMAL(10,2),
    TemperatureRangeMax DECIMAL(10,2),
    PressureRangeMin DECIMAL(10,2),
    PressureRangeMax DECIMAL(10,2),
    SafetyNotes TEXT,
    ProcessCategory VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10)
);

CREATE TABLE Reactants (
    ReactantID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    MolecularFormula VARCHAR(50),
    MolecularWeight DECIMAL(10,2),
    CASNumber VARCHAR(20) UNIQUE,
    Purity DECIMAL(5,2),
    Density DECIMAL(10,2),
    BoilingPoint DECIMAL(10,2),
    MeltingPoint DECIMAL(10,2),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsHazardous BIT NOT NULL DEFAULT 0,
    StorageConditions TEXT,
    SupplierContact VARCHAR(100),
    SafetyDataSheetURL VARCHAR(200),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    MolecularFormula VARCHAR(50),
    MolecularWeight DECIMAL(10,2),
    CASNumber VARCHAR(20) UNIQUE,
    Purity DECIMAL(5,2),
    Density DECIMAL(10,2),
    BoilingPoint DECIMAL(10,2),
    MeltingPoint DECIMAL(10,2),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsHazardous BIT NOT NULL DEFAULT 0,
    StorageConditions TEXT,
    SupplierContact VARCHAR(100),
    SafetyDataSheetURL VARCHAR(200),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE
);

CREATE TABLE Catalysts (
    CatalystID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Composition TEXT,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    CASNumber VARCHAR(20) UNIQUE,
    SurfaceArea DECIMAL(10,2),
    ParticleSize DECIMAL(10,2),
    ActivityLevel DECIMAL(5,2),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsReusable BIT NOT NULL DEFAULT 1,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    SafetyDataSheetURL VARCHAR(200),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    CatalystType VARCHAR(50)
);

CREATE TABLE Experiments (
    ExperimentID INT PRIMARY KEY IDENTITY(1,1),
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    Date DATE NOT NULL,
    Temperature DECIMAL(10,2),
    Pressure DECIMAL(10,2),
    Concentration DECIMAL(10,2),
    Yield DECIMAL(5,2) CHECK (Yield >= 0 AND Yield <= 100),
    ConversionRate DECIMAL(5,2) CHECK (ConversionRate >= 0 AND ConversionRate <= 100),
    LocationID INT FOREIGN KEY REFERENCES Locations(LocationID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    DurationMinutes INT,
    EquipmentCondition VARCHAR(100),
    SafetyCompliance BIT NOT NULL DEFAULT 1,
    ExperimentStatus VARCHAR(50),
    Notes TEXT,
    ApprovalStatus VARCHAR(50)
);

CREATE TABLE ExperimentConditions (
    ConditionID INT PRIMARY KEY IDENTITY(1,1),
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    ParameterName VARCHAR(50) NOT NULL,
    Value DECIMAL(10,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsCritical BIT NOT NULL DEFAULT 0,
    Tolerance DECIMAL(10,2),
    MeasurementMethod VARCHAR(100),
    CalibrationStatus VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    ParameterCategory VARCHAR(50),
    DocumentationURL VARCHAR(200),
    Notes TEXT
);

CREATE TABLE ReactionCategories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    IsActive BIT NOT NULL DEFAULT 1,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    CategoryCode VARCHAR(20),
    ParentCategoryID INT NULL, -- Self-referencing FK, allow NULL initially
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    IndustryStandard VARCHAR(50),
    UsageFrequency INT DEFAULT 0,
    SafetyRating INT CHECK (SafetyRating BETWEEN 1 AND 5),
    Notes TEXT
);

-- Update ReactionCategories to add self-referencing FK after table creation
ALTER TABLE ReactionCategories
ADD CONSTRAINT FK_ReactionCategories_ParentCategoryID FOREIGN KEY (ParentCategoryID) REFERENCES ReactionCategories(CategoryID);

CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(50),
    CalibrationDate DATE,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    Manufacturer VARCHAR(100),
    Model VARCHAR(50),
    SerialNumber VARCHAR(50) UNIQUE,
    MaintenanceSchedule VARCHAR(100),
    OperationalStatus VARCHAR(50),
    Cost DECIMAL(10,2),
    LocationID INT FOREIGN KEY REFERENCES Locations(LocationID),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    Notes TEXT
);

CREATE TABLE ReactionNotes (
    NoteID INT PRIMARY KEY IDENTITY(1,1),
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    Note TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    NoteCategory VARCHAR(50),
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    IsConfidential BIT NOT NULL DEFAULT 0,
    AttachmentURL VARCHAR(200),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    NoteType VARCHAR(50),
    ReferenceID VARCHAR(50),
    VisibilityLevel VARCHAR(50),
    CreatedByRole VARCHAR(50),
    Notes TEXT
);

CREATE TABLE ExperimentNotes (
    NoteID INT PRIMARY KEY IDENTITY(1,1),
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    Note TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    NoteCategory VARCHAR(50),
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    IsConfidential BIT NOT NULL DEFAULT 0,
    AttachmentURL VARCHAR(200),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    NoteType VARCHAR(50),
    ReferenceID VARCHAR(50),
    VisibilityLevel VARCHAR(50),
    CreatedByRole VARCHAR(50),
    Notes TEXT
);

CREATE TABLE ChemicalProperties (
    PropertyID INT PRIMARY KEY IDENTITY(1,1),
    ChemicalID INT, -- References ReactantID, ProductID, or CatalystID
    PropertyName VARCHAR(50) NOT NULL,
    Value DECIMAL(10,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    MeasurementMethod VARCHAR(100),
    Accuracy DECIMAL(5,2),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    PropertyCategory VARCHAR(50),
    DocumentationURL VARCHAR(200),
    IsCritical BIT NOT NULL DEFAULT 0,
    ValidationNotes TEXT,
    Notes TEXT
);

CREATE TABLE UnitsConversion (
    ConversionID INT PRIMARY KEY IDENTITY(1,1),
    FromUnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    ToUnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    ConversionFactor DECIMAL(10,4),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    ConversionCategory VARCHAR(50),
    DocumentationURL VARCHAR(200),
    IsBidirectional BIT NOT NULL DEFAULT 1,
    PrecisionLevel DECIMAL(5,2),
    ValidationNotes TEXT,
    UsageFrequency INT DEFAULT 0,
    ConversionCode VARCHAR(20),
    Notes TEXT
);

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName VARCHAR(50),
    Action VARCHAR(50),
    UserID INT FOREIGN KEY REFERENCES Researchers(ResearcherID),
    Timestamp DATETIME DEFAULT GETDATE(),
    OldValue TEXT,
    NewValue TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ActionCategory VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    LogLevel VARCHAR(50),
    TransactionID VARCHAR(50),
    Notes TEXT
);

CREATE TABLE ErrorLog (
    ErrorID INT PRIMARY KEY IDENTITY(1,1),
    ErrorMessage TEXT,
    Timestamp DATETIME DEFAULT GETDATE(),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ErrorCategory VARCHAR(50),
    SeverityLevel INT CHECK (SeverityLevel BETWEEN 1 AND 10),
    ErrorCode VARCHAR(20),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    ErrorSource VARCHAR(100),
    ResolutionStatus VARCHAR(50),
    ResolutionNotes TEXT,
    ErrorContext TEXT,
    Notes TEXT
);

-- Bridge Tables (15)
CREATE TABLE Reaction_Reactant (
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    ReactantID INT FOREIGN KEY REFERENCES Reactants(ReactantID),
    Stoichiometry DECIMAL(10,2),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    Concentration DECIMAL(10,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    PurityRequirement DECIMAL(5,2),
    SafetyNotes TEXT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    BatchNumber VARCHAR(50),
    DeliveryDate DATE,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    Notes TEXT,
    PRIMARY KEY (ReactionID, ReactantID)
);

CREATE TABLE Reaction_Product (
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Stoichiometry DECIMAL(10,2),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    YieldExpected DECIMAL(5,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    PurityRequirement DECIMAL(5,2),
    SafetyNotes TEXT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    BatchNumber VARCHAR(50),
    DeliveryDate DATE,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    Notes TEXT,
    PRIMARY KEY (ReactionID, ProductID)
);

CREATE TABLE Reaction_Catalyst (
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    CatalystID INT FOREIGN KEY REFERENCES Catalysts(CatalystID),
    CatalystAmount DECIMAL(10,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ActivityLevel DECIMAL(5,2),
    SafetyNotes TEXT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    BatchNumber VARCHAR(50),
    DeliveryDate DATE,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    ApplicationMethod VARCHAR(100),
    Notes TEXT,
    PRIMARY KEY (ReactionID, CatalystID)
);

CREATE TABLE Experiment_Reactant (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    ReactantID INT FOREIGN KEY REFERENCES Reactants(ReactantID),
    Concentration DECIMAL(10,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    Purity DECIMAL(5,2),
    SafetyNotes TEXT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    BatchNumber VARCHAR(50),
    DeliveryDate DATE,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    FeedRate DECIMAL(10,2),
    Notes TEXT,
    PRIMARY KEY (ExperimentID, ReactantID)
);

CREATE TABLE Experiment_Product (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Yield DECIMAL(5,2) CHECK (Yield >= 0 AND Yield <= 100),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    Purity DECIMAL(5,2),
    SafetyNotes TEXT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    BatchNumber VARCHAR(50),
    DeliveryDate DATE,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    QualityCheckStatus VARCHAR(50),
    Notes TEXT,
    PRIMARY KEY (ExperimentID, ProductID)
);

CREATE TABLE Experiment_Catalyst (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    CatalystID INT FOREIGN KEY REFERENCES Catalysts(CatalystID),
    CatalystAmount DECIMAL(10,2),
    UnitID INT FOREIGN KEY REFERENCES Units(UnitID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ActivityLevel DECIMAL(5,2),
    SafetyNotes TEXT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    BatchNumber VARCHAR(50),
    DeliveryDate DATE,
    StorageConditions TEXT,
    CostPerUnit DECIMAL(10,2),
    ApplicationMethod VARCHAR(100),
    Notes TEXT,
    PRIMARY KEY (ExperimentID, CatalystID)
);

CREATE TABLE Reaction_Category (
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    CategoryID INT FOREIGN KEY REFERENCES ReactionCategories(CategoryID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    CategoryWeight DECIMAL(5,2),
    DocumentationURL VARCHAR(200),
    IsPrimaryCategory BIT NOT NULL DEFAULT 0,
    ReferenceID VARCHAR(50),
    ValidationNotes TEXT,
    CreatedByRole VARCHAR(50),
    CategoryStatus VARCHAR(50),
    AssignmentDate DATE,
    Notes TEXT,
    PRIMARY KEY (ReactionID, CategoryID)
);

CREATE TABLE Experiment_Researcher (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    ResearcherID INT FOREIGN KEY REFERENCES Researchers(ResearcherID),
    Role VARCHAR(50),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ContributionLevel DECIMAL(5,2),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    AssignmentDate DATE,
    CompletionDate DATE,
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes TEXT,
    RoleCategory VARCHAR(50),
    SecurityClearance VARCHAR(50),
    DocumentationURL VARCHAR(200),
    PRIMARY KEY (ExperimentID, ResearcherID)
);

CREATE TABLE Experiment_Equipment (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    EquipmentID INT FOREIGN KEY REFERENCES Equipment(EquipmentID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    UsageDuration INT,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    CalibrationStatus VARCHAR(50),
    EquipmentCondition VARCHAR(100),
    MaintenanceNotes TEXT,
    CostPerUse DECIMAL(10,2),
    SetupTime INT,
    OperatorID INT FOREIGN KEY REFERENCES Researchers(ResearcherID),
    DocumentationURL VARCHAR(200),
    UsageStatus VARCHAR(50),
    Notes TEXT,
    PRIMARY KEY (ExperimentID, EquipmentID)
);

CREATE TABLE Reaction_Supplier (
    ReactionID INT FOREIGN KEY REFERENCES Reactions(ReactionID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ContractID VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DeliverySchedule VARCHAR(100),
    CostPerUnit DECIMAL(10,2),
    SupplierRating INT CHECK (SupplierRating BETWEEN 1 AND 5),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes TEXT,
    ContractStartDate DATE,
    ContractEndDate DATE,
    DocumentationURL VARCHAR(200),
    PRIMARY KEY (ReactionID, SupplierID)
);

CREATE TABLE Reactant_Supplier (
    ReactantID INT FOREIGN KEY REFERENCES Reactants(ReactantID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ContractID VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DeliverySchedule VARCHAR(100),
    CostPerUnit DECIMAL(10,2),
    SupplierRating INT CHECK (SupplierRating BETWEEN 1 AND 5),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes TEXT,
    ContractStartDate DATE,
    ContractEndDate DATE,
    DocumentationURL VARCHAR(200),
    PRIMARY KEY (ReactantID, SupplierID)
);

CREATE TABLE Product_Supplier (
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ContractID VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DeliverySchedule VARCHAR(100),
    CostPerUnit DECIMAL(10,2),
    SupplierRating INT CHECK (SupplierRating BETWEEN 1 AND 5),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes TEXT,
    ContractStartDate DATE,
    ContractEndDate DATE,
    DocumentationURL VARCHAR(200),
    PRIMARY KEY (ProductID, SupplierID)
);

CREATE TABLE Catalyst_Supplier (
    CatalystID INT FOREIGN KEY REFERENCES Catalysts(CatalystID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ContractID VARCHAR(50),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DeliverySchedule VARCHAR(100),
    CostPerUnit DECIMAL(10,2),
    SupplierRating INT CHECK (SupplierRating BETWEEN 1 AND 5),
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(20),
    Notes TEXT,
    ContractStartDate DATE,
    ContractEndDate DATE,
    DocumentationURL VARCHAR(200),
    PRIMARY KEY (CatalystID, SupplierID)
);

CREATE TABLE Experiment_Condition (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    ConditionID INT FOREIGN KEY REFERENCES ExperimentConditions(ConditionID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    Tolerance DECIMAL(10,2),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    MeasurementMethod VARCHAR(100),
    CalibrationStatus VARCHAR(50),
    ParameterCategory VARCHAR(50),
    DocumentationURL VARCHAR(200),
    IsCritical BIT NOT NULL DEFAULT 0,
    ValidationNotes TEXT,
    DataSource VARCHAR(50),
    ConditionStatus VARCHAR(50),
    Notes TEXT,
    PRIMARY KEY (ExperimentID, ConditionID)
);

CREATE TABLE ExperimentDataSources (
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    SourceID INT FOREIGN KEY REFERENCES DataSources(SourceID),
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    SourceWeight DECIMAL(5,2),
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    DocumentationURL VARCHAR(200),
    SourceCategory VARCHAR(50),
    ReliabilityScore INT CHECK (ReliabilityScore BETWEEN 1 AND 5),
    AssignmentDate DATE,
    Notes TEXT,
    SourceStatus VARCHAR(50),
    ValidationNotes TEXT,
    SourceReferenceID VARCHAR(50),
    SourcePriority INT CHECK (SourcePriority BETWEEN 1 AND 10),
    PRIMARY KEY (ExperimentID, SourceID)
);

CREATE TABLE ReportData (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    TemplateID INT FOREIGN KEY REFERENCES ReportTemplates(TemplateID),
    ExperimentID INT FOREIGN KEY REFERENCES Experiments(ExperimentID),
    GeneratedDate DATE DEFAULT GETDATE(),
    ReportContent TEXT,
    CreatedBy VARCHAR(100),
    CreatedDate DATE DEFAULT GETDATE(),
    ModifiedBy VARCHAR(100),
    ModifiedDate DATE,
    ApprovalStatus VARCHAR(50),
    LastValidatedDate DATE,
    ReportFormat VARCHAR(50),
    DistributionList TEXT,
    PriorityLevel INT CHECK (PriorityLevel BETWEEN 1 AND 10),
    DocumentationURL VARCHAR(200),
    ReportStatus VARCHAR(50),
    ReportSize INT,
    Notes TEXT
);


CREATE NONCLUSTERED INDEX IX_Experiments_Yield ON Experiments(Yield);
CREATE NONCLUSTERED INDEX IX_Experiments_Temperature ON Experiments(Temperature);
CREATE NONCLUSTERED INDEX IX_Experiments_Pressure ON Experiments(Pressure);
CREATE NONCLUSTERED INDEX IX_Experiments_Date ON Experiments(Date);
CREATE NONCLUSTERED INDEX IX_Experiments_ReactionID ON Experiments(ReactionID);
CREATE NONCLUSTERED INDEX IX_Reaction_Reactant_ReactionID ON Reaction_Reactant(ReactionID);
CREATE NONCLUSTERED INDEX IX_Reaction_Product_ReactionID ON Reaction_Product(ReactionID);
CREATE NONCLUSTERED INDEX IX_Reaction_Catalyst_CatalystID ON Reaction_Catalyst(CatalystID);
CREATE NONCLUSTERED INDEX IX_Experiment_Reactant_ReactantID ON Experiment_Reactant(ReactantID);
CREATE NONCLUSTERED INDEX IX_Experiment_Product_ProductID ON Experiment_Product(ProductID);
CREATE NONCLUSTERED INDEX IX_Experiment_Catalyst_CatalystID ON Experiment_Catalyst(CatalystID);
CREATE NONCLUSTERED INDEX IX_Experiment_Condition_ConditionID ON Experiment_Condition(ConditionID);
CREATE NONCLUSTERED INDEX IX_Experiment_Researcher_ResearcherID ON Experiment_Researcher(ResearcherID);
CREATE NONCLUSTERED INDEX IX_Experiment_Equipment_EquipmentID ON Experiment_Equipment(EquipmentID);
CREATE NONCLUSTERED INDEX IX_Reactants_CASNumber ON Reactants(CASNumber);
CREATE NONCLUSTERED INDEX IX_Products_CASNumber ON Products(CASNumber);
CREATE NONCLUSTERED INDEX IX_Catalysts_CASNumber ON Catalysts(CASNumber);
CREATE NONCLUSTERED INDEX IX_Reaction_Category_CategoryID ON Reaction_Category(CategoryID);
CREATE NONCLUSTERED INDEX IX_Experiments_LocationID ON Experiments(LocationID);
CREATE NONCLUSTERED INDEX IX_ChemicalProperties_PropertyName ON ChemicalProperties(PropertyName);


-- 1. InsertReaction
CREATE PROCEDURE InsertReaction
    @ReactionTypeID INT, @ReactionName VARCHAR(100), @Description TEXT, @CreatedBy VARCHAR(100),
    @EquilibriumConstant DECIMAL(10,4), @RateConstant DECIMAL(10,4), @TemperatureRangeMin DECIMAL(10,2),
    @TemperatureRangeMax DECIMAL(10,2), @PressureRangeMin DECIMAL(10,2), @PressureRangeMax DECIMAL(10,2),
    @SafetyNotes TEXT, @ProcessCategory VARCHAR(50), @ApprovalStatus VARCHAR(50), @DocumentationURL VARCHAR(200),
    @PriorityLevel INT
AS
BEGIN
    INSERT INTO Reactions (ReactionTypeID, ReactionName, Description, CreatedBy, EquilibriumConstant, RateConstant,
        TemperatureRangeMin, TemperatureRangeMax, PressureRangeMin, PressureRangeMax, SafetyNotes, ProcessCategory,
        ApprovalStatus, DocumentationURL, PriorityLevel)
    VALUES (@ReactionTypeID, @ReactionName, @Description, @CreatedBy, @EquilibriumConstant, @RateConstant,
        @TemperatureRangeMin, @TemperatureRangeMax, @PressureRangeMin, @PressureRangeMax, @SafetyNotes, @ProcessCategory,
        @ApprovalStatus, @DocumentationURL, @PriorityLevel);
END;
GO

-- 2. InsertExperiment
CREATE PROCEDURE InsertExperiment
    @ReactionID INT, @Date DATE, @Temperature DECIMAL(10,2), @Pressure DECIMAL(10,2), @Concentration DECIMAL(10,2),
    @Yield DECIMAL(5,2), @ConversionRate DECIMAL(5,2), @LocationID INT, @CreatedBy VARCHAR(100), @DurationMinutes INT,
    @EquipmentCondition VARCHAR(100), @SafetyCompliance BIT, @ExperimentStatus VARCHAR(50), @Notes TEXT, @ApprovalStatus VARCHAR(50)
AS
BEGIN
    INSERT INTO Experiments (ReactionID, Date, Temperature, Pressure, Concentration, Yield, ConversionRate, LocationID,
        CreatedBy, DurationMinutes, EquipmentCondition, SafetyCompliance, ExperimentStatus, Notes, ApprovalStatus)
    VALUES (@ReactionID, @Date, @Temperature, @Pressure, @Concentration, @Yield, @ConversionRate, @LocationID,
        @CreatedBy, @DurationMinutes, @EquipmentCondition, @SafetyCompliance, @ExperimentStatus, @Notes, @ApprovalStatus);
END;
GO

-- 3. InsertReactant
CREATE PROCEDURE InsertReactant
    @Name VARCHAR(100), @MolecularFormula VARCHAR(50), @MolecularWeight DECIMAL(10,2), @CASNumber VARCHAR(20),
    @Purity DECIMAL(5,2), @Density DECIMAL(10,2), @BoilingPoint DECIMAL(10,2), @MeltingPoint DECIMAL(10,2),
    @CreatedBy VARCHAR(100), @IsHazardous BIT, @StorageConditions TEXT, @SupplierContact VARCHAR(100),
    @SafetyDataSheetURL VARCHAR(200), @ApprovalStatus VARCHAR(50)
AS
BEGIN
    INSERT INTO Reactants (Name, MolecularFormula, MolecularWeight, CASNumber, Purity, Density, BoilingPoint, MeltingPoint,
        CreatedBy, IsHazardous, StorageConditions, SupplierContact, SafetyDataSheetURL, ApprovalStatus)
    VALUES (@Name, @MolecularFormula, @MolecularWeight, @CASNumber, @Purity, @Density, @BoilingPoint, @MeltingPoint,
        @CreatedBy, @IsHazardous, @StorageConditions, @SupplierContact, @SafetyDataSheetURL, @ApprovalStatus);
END;
GO

-- 4. InsertProduct
CREATE PROCEDURE InsertProduct
    @Name VARCHAR(100), @MolecularFormula VARCHAR(50), @MolecularWeight DECIMAL(10,2), @CASNumber VARCHAR(20),
    @Purity DECIMAL(5,2), @Density DECIMAL(10,2), @BoilingPoint DECIMAL(10,2), @MeltingPoint DECIMAL(10,2),
    @CreatedBy VARCHAR(100), @IsHazardous BIT, @StorageConditions TEXT, @SupplierContact VARCHAR(100),
    @SafetyDataSheetURL VARCHAR(200), @ApprovalStatus VARCHAR(50)
AS
BEGIN
    INSERT INTO Products (Name, MolecularFormula, MolecularWeight, CASNumber, Purity, Density, BoilingPoint, MeltingPoint,
        CreatedBy, IsHazardous, StorageConditions, SupplierContact, SafetyDataSheetURL, ApprovalStatus)
    VALUES (@Name, @MolecularFormula, @MolecularWeight, @CASNumber, @Purity, @Density, @BoilingPoint, @MeltingPoint,
        @CreatedBy, @IsHazardous, @StorageConditions, @SupplierContact, @SafetyDataSheetURL, @ApprovalStatus);
END;
GO

-- 5. InsertCatalyst
CREATE PROCEDURE InsertCatalyst
    @Name VARCHAR(100), @Composition TEXT, @SupplierID INT, @CASNumber VARCHAR(20), @SurfaceArea DECIMAL(10,2),
    @ParticleSize DECIMAL(10,2), @ActivityLevel DECIMAL(5,2), @CreatedBy VARCHAR(100), @IsReusable BIT,
    @StorageConditions TEXT, @CostPerUnit DECIMAL(10,2), @SafetyDataSheetURL VARCHAR(200), @ApprovalStatus VARCHAR(50),
    @CatalystType VARCHAR(50)
AS
BEGIN
    INSERT INTO Catalysts (Name, Composition, SupplierID, CASNumber, SurfaceArea, ParticleSize, ActivityLevel, CreatedBy,
        IsReusable, StorageConditions, CostPerUnit, SafetyDataSheetURL, ApprovalStatus, CatalystType)
    VALUES (@Name, @Composition, @SupplierID, @CASNumber, @SurfaceArea, @ParticleSize, @ActivityLevel, @CreatedBy,
        @IsReusable, @StorageConditions, @CostPerUnit, @SafetyDataSheetURL, @ApprovalStatus, @CatalystType);
END;
GO

-- 6. UpdateReaction
CREATE PROCEDURE UpdateReaction
    @ReactionID INT, @ReactionName VARCHAR(100), @Description TEXT, @ModifiedBy VARCHAR(100),
    @EquilibriumConstant DECIMAL(10,4), @RateConstant DECIMAL(10,4), @ApprovalStatus VARCHAR(50)
AS
BEGIN
    UPDATE Reactions
    SET ReactionName = @ReactionName, Description = @Description, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE(),
        EquilibriumConstant = @EquilibriumConstant, RateConstant = @RateConstant, ApprovalStatus = @ApprovalStatus
    WHERE ReactionID = @ReactionID;
END;
GO

-- 7. UpdateExperiment
CREATE PROCEDURE UpdateExperiment
    @ExperimentID INT, @Temperature DECIMAL(10,2), @Pressure DECIMAL(10,2), @Yield DECIMAL(5,2),
    @ConversionRate DECIMAL(5,2), @ModifiedBy VARCHAR(100), @ApprovalStatus VARCHAR(50)
AS
BEGIN
    UPDATE Experiments
    SET Temperature = @Temperature, Pressure = @Pressure, Yield = @Yield, ConversionRate = @ConversionRate,
        ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE(), ApprovalStatus = @ApprovalStatus
    WHERE ExperimentID = @ExperimentID;
END;
GO

-- 8. UpdateReactant
CREATE PROCEDURE UpdateReactant
    @ReactantID INT, @Name VARCHAR(100), @MolecularFormula VARCHAR(50), @ModifiedBy VARCHAR(100),
    @ApprovalStatus VARCHAR(50)
AS
BEGIN
    UPDATE Reactants
    SET Name = @Name, MolecularFormula = @MolecularFormula, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE(),
        ApprovalStatus = @ApprovalStatus
    WHERE ReactantID = @ReactantID;
END;
GO

-- 9. UpdateProduct
CREATE PROCEDURE UpdateProduct
    @ProductID INT, @Name VARCHAR(100), @MolecularFormula VARCHAR(50), @ModifiedBy VARCHAR(100),
    @ApprovalStatus VARCHAR(50)
AS
BEGIN
    UPDATE Products
    SET Name = @Name, MolecularFormula = @MolecularFormula, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE(),
        ApprovalStatus = @ApprovalStatus
    WHERE ProductID = @ProductID;
END;
GO

-- 10. UpdateCatalyst
CREATE PROCEDURE UpdateCatalyst
    @CatalystID INT, @Name VARCHAR(100), @Composition TEXT, @ModifiedBy VARCHAR(100), @ApprovalStatus VARCHAR(50)
AS
BEGIN
    UPDATE Catalysts
    SET Name = @Name, Composition = @Composition, ModifiedBy = @ModifiedBy, ModifiedDate = GETDATE(),
        ApprovalStatus = @ApprovalStatus
    WHERE CatalystID = @CatalystID;
END;
GO

-- 11. DeleteReaction
CREATE PROCEDURE DeleteReaction
    @ReactionID INT
AS
BEGIN
    DELETE FROM Reaction_Reactant WHERE ReactionID = @ReactionID;
    DELETE FROM Reaction_Product WHERE ReactionID = @ReactionID;
    DELETE FROM Reaction_Catalyst WHERE ReactionID = @ReactionID;
    DELETE FROM Reactions WHERE ReactionID = @ReactionID;
END;
GO

-- 12. DeleteExperiment
CREATE PROCEDURE DeleteExperiment
    @ExperimentID INT
AS
BEGIN
    DELETE FROM Experiment_Reactant WHERE ExperimentID = @ExperimentID;
    DELETE FROM Experiment_Product WHERE ExperimentID = @ExperimentID;
    DELETE FROM Experiment_Catalyst WHERE ExperimentID = @ExperimentID;
    DELETE FROM Experiments WHERE ExperimentID = @ExperimentID;
END;
GO

-- 13. DeleteReactant
CREATE PROCEDURE DeleteReactant
    @ReactantID INT
AS
BEGIN
    DELETE FROM Reaction_Reactant WHERE ReactantID = @ReactantID;
    DELETE FROM Experiment_Reactant WHERE ReactantID = @ReactantID;
    DELETE FROM Reactants WHERE ReactantID = @ReactantID;
END;
GO

-- 14. DeleteProduct
CREATE PROCEDURE DeleteProduct
    @ProductID INT
AS
BEGIN
    DELETE FROM Reaction_Product WHERE ProductID = @ProductID;
    DELETE FROM Experiment_Product WHERE ProductID = @ProductID;
    DELETE FROM Products WHERE ProductID = @ProductID;
END;
GO

-- 15. DeleteCatalyst
CREATE PROCEDURE DeleteCatalyst
    @CatalystID INT
AS
BEGIN
    DELETE FROM Reaction_Catalyst WHERE CatalystID = @CatalystID;
    DELETE FROM Experiment_Catalyst WHERE CatalystID = @CatalystID;
    DELETE FROM Catalysts WHERE CatalystID = @CatalystID;
END;
GO

-- 16. GetExperimentsByYield
CREATE PROCEDURE GetExperimentsByYield
    @MinYield DECIMAL(5,2)
AS
BEGIN
    SELECT e.ExperimentID, r.ReactionName, e.Yield, e.Temperature, e.Pressure, e.ConversionRate
    FROM Experiments e
    JOIN Reactions r ON e.ReactionID = r.ReactionID
    WHERE e.Yield > @MinYield
    ORDER BY e.Yield DESC;
END;
GO

-- 17. GetExperimentsByCatalyst
CREATE PROCEDURE GetExperimentsByCatalyst
    @CatalystID INT
AS
BEGIN
    SELECT e.ExperimentID, r.ReactionName, e.Yield, e.Temperature, e.Pressure, c.Name AS CatalystName
    FROM Experiments e
    JOIN Reactions r ON e.ReactionID = r.ReactionID
    JOIN Experiment_Catalyst ec ON e.ExperimentID = ec.ExperimentID
    JOIN Catalysts c ON ec.CatalystID = c.CatalystID
    WHERE ec.CatalystID = @CatalystID
    ORDER BY e.Yield DESC;
END;
GO

-- 18. GetOptimalConditions
CREATE PROCEDURE GetOptimalConditions
    @ReactionID INT
AS
BEGIN
    SELECT TOP 1 e.ExperimentID, e.Temperature, e.Pressure, e.Concentration, e.Yield, e.ConversionRate
    FROM Experiments e
    WHERE e.ReactionID = @ReactionID
    ORDER BY e.Yield DESC;
END;
GO

-- 19. GetReactionSummary
CREATE PROCEDURE GetReactionSummary
    @ReactionID INT
AS
BEGIN
    SELECT r.ReactionName, rt.TypeName, AVG(e.Yield) AS AvgYield, MAX(e.Yield) AS MaxYield,
        MIN(e.Yield) AS MinYield, COUNT(e.ExperimentID) AS ExperimentCount
    FROM Reactions r
    JOIN ReactionTypes rt ON r.ReactionTypeID = rt.TypeID
    JOIN Experiments e ON r.ReactionID = e.ReactionID
    WHERE r.ReactionID = @ReactionID
    GROUP BY r.ReactionName, rt.TypeName;
END;
GO

-- 20. GetExperimentsByDateRange
CREATE PROCEDURE GetExperimentsByDateRange
    @StartDate DATE, @EndDate DATE
AS
BEGIN
    SELECT e.ExperimentID, r.ReactionName, e.Date, e.Yield, e.Temperature, e.Pressure
    FROM Experiments e
    JOIN Reactions r ON e.ReactionID = r.ReactionID
    WHERE e.Date BETWEEN @StartDate AND @EndDate
    ORDER BY e.Date;
END;
GO

-- 21. GetTopCatalysts
CREATE PROCEDURE GetTopCatalysts
    @TopN INT
AS
BEGIN
    SELECT TOP (@TopN) c.Name, AVG(e.Yield) AS AvgYield, COUNT(e.ExperimentID) AS ExperimentCount
    FROM Catalysts c
    JOIN Experiment_Catalyst ec ON c.CatalystID = ec.CatalystID
    JOIN Experiments e ON ec.ExperimentID = e.ExperimentID
    GROUP BY c.Name
    ORDER BY AvgYield DESC;
END;
GO

-- 22. GetYieldTrends
CREATE PROCEDURE GetYieldTrends
    @ReactionID INT
AS
BEGIN
    SELECT e.Date, AVG(e.Yield) AS AvgYield
    FROM Experiments e
    WHERE e.ReactionID = @ReactionID
    GROUP BY e.Date
    ORDER BY e.Date;
END;
GO

-- 23. GetExperimentsByLocation
CREATE PROCEDURE GetExperimentsByLocation
    @LocationID INT
AS
BEGIN
    SELECT e.ExperimentID, r.ReactionName, e.Yield, e.Temperature, e.Pressure, l.RefineryName
    FROM Experiments e
    JOIN Reactions r ON e.ReactionID = r.ReactionID
    JOIN Locations l ON e.LocationID = l.LocationID
    WHERE e.LocationID = @LocationID
    ORDER BY e.Yield DESC;
END;
GO

-- 24. GetReactionReactants
CREATE PROCEDURE GetReactionReactants
    @ReactionID INT
AS
BEGIN
    SELECT r.ReactionName, rt.Name AS ReactantName, rr.Stoichiometry
    FROM Reactions r
    JOIN Reaction_Reactant rr ON r.ReactionID = rr.ReactionID
    JOIN Reactants rt ON rr.ReactantID = rt.ReactantID
    WHERE r.ReactionID = @ReactionID;
END;
GO

-- 25. GetExperimentConditions
CREATE PROCEDURE GetExperimentConditions
    @ExperimentID INT
AS
BEGIN
    SELECT ec.ParameterName, ec.Value, u.UnitName
    FROM ExperimentConditions ec
    JOIN Units u ON ec.UnitID = u.UnitID
    WHERE ec.ExperimentID = @ExperimentID;
END;
GO

-- 26. GenerateYieldReport
CREATE PROCEDURE GenerateYieldReport
    @ReactionID INT
AS
BEGIN
    INSERT INTO ReportData (TemplateID, ExperimentID, ReportContent, ReportFormat)
    SELECT 1, e.ExperimentID, 
        'Reaction: ' + r.ReactionName + ', Yield: ' + CAST(e.Yield AS VARCHAR(10)) + 
        ', Temperature: ' + CAST(e.Temperature AS VARCHAR(10)) + 
        ', Pressure: ' + CAST(e.Pressure AS VARCHAR(10)), 'TEXT'
    FROM Experiments e
    JOIN Reactions r ON e.ReactionID = r.ReactionID
    WHERE e.ReactionID = @ReactionID;
END;
GO

-- 27. GenerateCatalystPerformanceReport
CREATE PROCEDURE GenerateCatalystPerformanceReport
    @CatalystID INT
AS
BEGIN
    INSERT INTO ReportData (TemplateID, ExperimentID, ReportContent, ReportFormat)
    SELECT 2, e.ExperimentID,
        'Catalyst: ' + c.Name + ', Yield: ' + CAST(e.Yield AS VARCHAR(10)) + 
        ', ActivityLevel: ' + CAST(ec.ActivityLevel AS VARCHAR(10)), 'TEXT'
    FROM Experiments e
    JOIN Experiment_Catalyst ec ON e.ExperimentID = ec.ExperimentID
    JOIN Catalysts c ON ec.CatalystID = c.CatalystID
    WHERE ec.CatalystID = @CatalystID;
END;
GO

-- 28. GenerateConditionOptimizationReport
CREATE PROCEDURE GenerateConditionOptimizationReport
    @ReactionID INT
AS
BEGIN
    INSERT INTO ReportData (TemplateID, ExperimentID, ReportContent, ReportFormat)
    SELECT 3, e.ExperimentID,
        'Optimal Conditions for ' + r.ReactionName + ': Temperature=' + CAST(e.Temperature AS VARCHAR(10)) + 
        ', Pressure=' + CAST(e.Pressure AS VARCHAR(10)) + ', Yield=' + CAST(e.Yield AS VARCHAR(10)), 'TEXT'
    FROM Experiments e
    JOIN Reactions r ON e.ReactionID = r.ReactionID
    WHERE e.ReactionID = @ReactionID
    AND e.Yield = (SELECT MAX(Yield) FROM Experiments WHERE ReactionID = @ReactionID);
END;
GO

-- 29. ConvertUnits
CREATE PROCEDURE ConvertUnits
    @Value DECIMAL(10,2), @FromUnitID INT, @ToUnitID INT, @ConvertedValue DECIMAL(10,2) OUTPUT
AS
BEGIN
    SELECT @ConvertedValue = @Value * ConversionFactor
    FROM UnitsConversion
    WHERE FromUnitID = @FromUnitID AND ToUnitID = @ToUnitID;
END;
GO

-- 30. ValidateDataIntegrity
CREATE PROCEDURE ValidateDataIntegrity
AS
BEGIN
    SELECT 'Missing ReactionTypeID' AS Issue, ReactionID
    FROM Reactions
    WHERE ReactionTypeID IS NULL
    UNION
    SELECT 'Invalid Yield' AS Issue, ExperimentID
    FROM Experiments
    WHERE Yield < 0 OR Yield > 100
    UNION
    SELECT 'Missing UnitID in ExperimentConditions' AS Issue, ConditionID
    FROM ExperimentConditions
    WHERE UnitID IS NULL;
END;
GO

USE ChemKineticsDB;
GO

-- 1. ReactionTypes (Auxiliary)
INSERT INTO ReactionTypes (TypeName, Description, IsExothermic, SafetyRating, CreatedBy, StandardEnthalpy, ActivationEnergy, ReactionOrder, FrequencyFactor, DocumentationURL, ApprovalStatus, ReviewDate, Notes, PriorityLevel, CategoryCode, LastValidatedDate)
VALUES
('Exothermic', 'Exothermic reaction type', 1, 3, 'Admin', -100.50, 50.25, 1.5, 1000.0, 'http://example.com/exo1', 'Approved', '2025-09-01', 'Standard exothermic reaction', 5, 'EXO001', '2025-09-01'),
('Endothermic', 'Endothermic reaction type', 0, 2, 'Admin', 80.75, 60.50, 2.0, 1200.0, 'http://example.com/endo1', 'Approved', '2025-09-01', 'Requires heat input', 4, 'ENDO001', '2025-09-01'),
('Catalytic', 'Catalytic reaction type', 1, 4, 'Admin', -150.25, 45.75, 1.0, 900.0, 'http://example.com/cat1', 'Approved', '2025-09-01', 'Catalyst-driven', 6, 'CAT001', '2025-09-01'),
('Polymerization', 'Polymerization reaction', 1, 3, 'Admin', -200.00, 55.00, 1.8, 1100.0, 'http://example.com/poly1', 'Approved', '2025-09-01', 'High molecular weight products', 7, 'POLY001', '2025-09-01'),
('Cracking', 'Catalytic cracking reaction', 1, 4, 'Admin', -120.50, 48.25, 1.2, 950.0, 'http://example.com/crack1', 'Approved', '2025-09-01', 'Hydrocarbon breakdown', 6, 'CRK001', '2025-09-01'),
('Hydrogenation', 'Hydrogen addition reaction', 1, 3, 'Admin', -130.75, 52.50, 1.5, 1050.0, 'http://example.com/hyd1', 'Approved', '2025-09-01', 'Hydrogen addition', 5, 'HYD001', '2025-09-01'),
('Oxidation', 'Oxidation reaction', 1, 4, 'Admin', -110.25, 47.75, 1.3, 980.0, 'http://example.com/ox1', 'Approved', '2025-09-01', 'Oxygen addition', 6, 'OX001', '2025-09-01'),
('Reduction', 'Reduction reaction', 0, 2, 'Admin', 90.50, 58.00, 2.1, 1150.0, 'http://example.com/red1', 'Approved', '2025-09-01', 'Electron gain', 4, 'RED001', '2025-09-01'),
('Isomerization', 'Isomer rearrangement', 0, 3, 'Admin', 20.25, 49.50, 1.4, 990.0, 'http://example.com/iso1', 'Approved', '2025-09-01', 'Structural rearrangement', 5, 'ISO001', '2025-09-01'),
('Alkylation', 'Alkyl group addition', 1, 4, 'Admin', -140.75, 53.25, 1.6, 1080.0, 'http://example.com/alk1', 'Approved', '2025-09-01', 'Alkyl addition', 6, 'ALK001', '2025-09-01'),
('Dehydrogenation', 'Hydrogen removal reaction', 0, 3, 'Admin', 100.50, 57.75, 1.9, 1120.0, 'http://example.com/deh1', 'Approved', '2025-09-01', 'Hydrogen removal', 5, 'DEH001', '2025-09-01'),
('Esterification', 'Ester formation reaction', 1, 3, 'Admin', -115.25, 50.00, 1.7, 1030.0, 'http://example.com/est1', 'Approved', '2025-09-01', 'Ester formation', 5, 'EST001', '2025-09-01'),
('Hydrolysis', 'Water-mediated cleavage', 0, 2, 'Admin', 85.75, 59.50, 2.0, 1170.0, 'http://example.com/hydr1', 'Approved', '2025-09-01', 'Water cleavage', 4, 'HYDR001', '2025-09-01'),
('Condensation', 'Condensation reaction', 1, 3, 'Admin', -125.50, 51.25, 1.5, 1010.0, 'http://example.com/con1', 'Approved', '2025-09-01', 'Molecule combination', 5, 'CON001', '2025-09-01'),
('Neutralization', 'Acid-base reaction', 0, 2, 'Admin', 30.25, 48.75, 1.3, 970.0, 'http://example.com/neu1', 'Approved', '2025-09-01', 'Acid-base', 4, 'NEU001', '2025-09-01'),
('Saponification', 'Soap formation reaction', 1, 3, 'Admin', -135.75, 54.50, 1.6, 1090.0, 'http://example.com/sap1', 'Approved', '2025-09-01', 'Soap production', 5, 'SAP001', '2025-09-01'),
('Reforming', 'Catalytic reforming', 1, 4, 'Admin', -145.25, 52.75, 1.4, 1040.0, 'http://example.com/ref1', 'Approved', '2025-09-01', 'Hydrocarbon restructuring', 6, 'REF001', '2025-09-01'),
('Desulfurization', 'Sulfur removal reaction', 1, 4, 'Admin', -155.50, 55.25, 1.7, 1110.0, 'http://example.com/des1', 'Approved', '2025-09-01', 'Sulfur removal', 6, 'DES001', '2025-09-01'),
('Amination', 'Amine formation reaction', 0, 3, 'Admin', 95.75, 58.50, 1.9, 1160.0, 'http://example.com/ami1', 'Approved', '2025-09-01', 'Amine production', 5, 'AMI001', '2025-09-01'),
('Halogenation', 'Halogen addition reaction', 1, 4, 'Admin', -165.25, 56.75, 1.8, 1130.0, 'http://example.com/hal1', 'Approved', '2025-09-01', 'Halogen addition', 6, 'HAL001', '2025-09-01'),
('Nitration', 'Nitro group addition', 1, 4, 'Admin', -175.50, 57.25, 1.9, 1140.0, 'http://example.com/nit1', 'Approved', '2025-09-01', 'Nitro group addition', 6, 'NIT001', '2025-09-01'),
('Sulfonation', 'Sulfonic acid formation', 1, 4, 'Admin', -185.75, 58.50, 2.0, 1150.0, 'http://example.com/sul1', 'Approved', '2025-09-01', 'Sulfonic acid production', 6, 'SUL001', '2025-09-01'),
('Fermentation', 'Biochemical reaction', 0, 2, 'Admin', 70.25, 59.75, 2.1, 1180.0, 'http://example.com/fer1', 'Approved', '2025-09-01', 'Biochemical process', 4, 'FER001', '2025-09-01'),
('Photochemical', 'Light-driven reaction', 0, 3, 'Admin', 60.50, 60.25, 1.5, 1190.0, 'http://example.com/pho1', 'Approved', '2025-09-01', 'Light-driven', 5, 'PHO001', '2025-09-01'),
('Electrochemical', 'Electron-driven reaction', 0, 3, 'Admin', 50.75, 61.50, 1.6, 1200.0, 'http://example.com/ele1', 'Approved', '2025-09-01', 'Electron-driven', 5, 'ELE001', '2025-09-01');

-- 2. ReactionStatus (Auxiliary)
INSERT INTO ReactionStatus (StatusName, Description, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsActive, PriorityLevel, StatusCategory, ApprovalStatus, LastValidatedDate, DocumentationURL, UsageFrequency, StatusCode, VisibilityLevel, CreatedByRole, Notes)
VALUES
('Active', 'Reaction is active', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat1', 100, 'ACT001', 'Public', 'Admin', 'Standard active status'),
('Inactive', 'Reaction is inactive', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat2', 50, 'INA001', 'Public', 'Admin', 'Not in use'),
('Under Review', 'Reaction under review', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Review', 'Pending', '2025-09-01', 'http://example.com/stat3', 20, 'REV001', 'Restricted', 'Admin', 'Awaiting approval'),
('Archived', 'Reaction archived', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat4', 10, 'ARC001', 'Public', 'Admin', 'Historical data'),
('Suspended', 'Reaction suspended', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Pending', '2025-09-01', 'http://example.com/stat5', 15, 'SUS001', 'Restricted', 'Admin', 'Temporary hold'),
('Planned', 'Reaction planned', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Planning', 'Pending', '2025-09-01', 'http://example.com/stat6', 25, 'PLA001', 'Public', 'Admin', 'Future experiment'),
('Completed', 'Reaction completed', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat7', 30, 'COM001', 'Public', 'Admin', 'Finished experiments'),
('Testing', 'Reaction in testing', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Testing', 'Pending', '2025-09-01', 'http://example.com/stat8', 40, 'TES001', 'Restricted', 'Admin', 'Under testing'),
('Validated', 'Reaction validated', 'Admin', '2025-09-01', NULL, NULL, 1, 6, 'Validation', 'Approved', '2025-09-01', 'http://example.com/stat9', 35, 'VAL001', 'Public', 'Admin', 'Validated data'),
('Deprecated', 'Reaction deprecated', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat10', 5, 'DEP001', 'Public', 'Admin', 'Obsolete reaction'),
('On Hold', 'Reaction on hold', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Pending', '2025-09-01', 'http://example.com/stat11', 15, 'HOL001', 'Restricted', 'Admin', 'Temporary pause'),
('In Progress', 'Reaction in progress', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Operational', 'Pending', '2025-09-01', 'http://example.com/stat12', 45, 'PRO001', 'Public', 'Admin', 'Ongoing'),
('Failed', 'Reaction failed', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Rejected', '2025-09-01', 'http://example.com/stat13', 10, 'FAI001', 'Restricted', 'Admin', 'Failed experiment'),
('Cancelled', 'Reaction cancelled', 'Admin', '2025-09-01', NULL, NULL, 0, 1, 'Operational', 'Rejected', '2025-09-01', 'http://example.com/stat14', 5, 'CAN001', 'Public', 'Admin', 'Cancelled experiment'),
('Proposed', 'Reaction proposed', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Planning', 'Pending', '2025-09-01', 'http://example.com/stat15', 20, 'PROP001', 'Restricted', 'Admin', 'Proposed for review'),
('Approved', 'Reaction approved', 'Admin', '2025-09-01', NULL, NULL, 1, 6, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat16', 50, 'APP001', 'Public', 'Admin', 'Approved for use'),
('Experimental', 'Experimental reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Testing', 'Pending', '2025-09-01', 'http://example.com/stat17', 30, 'EXP001', 'Restricted', 'Admin', 'Experimental phase'),
('Obsolete', 'Reaction obsolete', 'Admin', '2025-09-01', NULL, NULL, 0, 1, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat18', 5, 'OBS001', 'Public', 'Admin', 'No longer used'),
('Scheduled', 'Reaction scheduled', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Planning', 'Pending', '2025-09-01', 'http://example.com/stat19', 25, 'SCH001', 'Public', 'Admin', 'Scheduled for experiment'),
('Under Maintenance', 'Reaction under maintenance', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Pending', '2025-09-01', 'http://example.com/stat20', 15, 'MAIN001', 'Restricted', 'Admin', 'Maintenance phase'),
('Discontinued', 'Reaction discontinued', 'Admin', '2025-09-01', NULL, NULL, 0, 1, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat21', 10, 'DIS001', 'Public', 'Admin', 'Discontinued reaction'),
('In Validation', 'Reaction in validation', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Validation', 'Pending', '2025-09-01', 'http://example.com/stat22', 35, 'VAL002', 'Restricted', 'Admin', 'Validation phase'),
('On Trial', 'Reaction on trial', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Testing', 'Pending', '2025-09-01', 'http://example.com/stat23', 40, 'TRI001', 'Restricted', 'Admin', 'Trial phase'),
('Awaiting Data', 'Awaiting reaction data', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Operational', 'Pending', '2025-09-01', 'http://example.com/stat24', 20, 'AWD001', 'Public', 'Admin', 'Awaiting data'),
('Closed', 'Reaction closed', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Approved', '2025-09-01', 'http://example.com/stat25', 10, 'CLO001', 'Public', 'Admin', 'Closed reaction');

-- 3. ExperimentStatus (Auxiliary)
INSERT INTO ExperimentStatus (StatusName, Description, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsActive, PriorityLevel, StatusCategory, ApprovalStatus, LastValidatedDate, DocumentationURL, UsageFrequency, StatusCode, VisibilityLevel, CreatedByRole, Notes)
VALUES
('Completed', 'Experiment completed', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat1', 100, 'COM001', 'Public', 'Admin', 'Finished experiment'),
('In Progress', 'Experiment in progress', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Operational', 'Pending', '2025-09-01', 'http://example.com/expstat2', 50, 'PRO001', 'Public', 'Admin', 'Ongoing experiment'),
('Planned', 'Experiment planned', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Planning', 'Pending', '2025-09-01', 'http://example.com/expstat3', 25, 'PLA001', 'Public', 'Admin', 'Future experiment'),
('Cancelled', 'Experiment cancelled', 'Admin', '2025-09-01', NULL, NULL, 0, 1, 'Operational', 'Rejected', '2025-09-01', 'http://example.com/expstat4', 10, 'CAN001', 'Public', 'Admin', 'Cancelled experiment'),
('Failed', 'Experiment failed', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Rejected', '2025-09-01', 'http://example.com/expstat5', 15, 'FAI001', 'Restricted', 'Admin', 'Failed experiment'),
('Under Review', 'Experiment under review', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Review', 'Pending', '2025-09-01', 'http://example.com/expstat6', 20, 'REV001', 'Restricted', 'Admin', 'Awaiting approval'),
('Suspended', 'Experiment suspended', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Pending', '2025-09-01', 'http://example.com/expstat7', 15, 'SUS001', 'Restricted', 'Admin', 'Temporary hold'),
('Testing', 'Experiment in testing', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Testing', 'Pending', '2025-09-01', 'http://example.com/expstat8', 40, 'TES001', 'Restricted', 'Admin', 'Testing phase'),
('Validated', 'Experiment validated', 'Admin', '2025-09-01', NULL, NULL, 1, 6, 'Validation', 'Approved', '2025-09-01', 'http://example.com/expstat9', 35, 'VAL001', 'Public', 'Admin', 'Validated data'),
('On Hold', 'Experiment on hold', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Pending', '2025-09-01', 'http://example.com/expstat10', 15, 'HOL001', 'Restricted', 'Admin', 'Temporary pause'),
('Scheduled', 'Experiment scheduled', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Planning', 'Pending', '2025-09-01', 'http://example.com/expstat11', 25, 'SCH001', 'Public', 'Admin', 'Scheduled experiment'),
('Deprecated', 'Experiment deprecated', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat12', 5, 'DEP001', 'Public', 'Admin', 'Obsolete experiment'),
('Proposed', 'Experiment proposed', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Planning', 'Pending', '2025-09-01', 'http://example.com/expstat13', 20, 'PROP001', 'Restricted', 'Admin', 'Proposed for review'),
('Approved', 'Experiment approved', 'Admin', '2025-09-01', NULL, NULL, 1, 6, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat14', 50, 'APP001', 'Public', 'Admin', 'Approved for execution'),
('Experimental', 'Experimental phase', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Testing', 'Pending', '2025-09-01', 'http://example.com/expstat15', 30, 'EXP001', 'Restricted', 'Admin', 'Experimental phase'),
('Obsolete', 'Experiment obsolete', 'Admin', '2025-09-01', NULL, NULL, 0, 1, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat16', 5, 'OBS001', 'Public', 'Admin', 'No longer used'),
('Under Maintenance', 'Experiment under maintenance', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Pending', '2025-09-01', 'http://example.com/expstat17', 15, 'MAIN001', 'Restricted', 'Admin', 'Maintenance phase'),
('Discontinued', 'Experiment discontinued', 'Admin', '2025-09-01', NULL, NULL, 0, 1, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat18', 10, 'DIS001', 'Public', 'Admin', 'Discontinued experiment'),
('In Validation', 'Experiment in validation', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Validation', 'Pending', '2025-09-01', 'http://example.com/expstat19', 35, 'VAL002', 'Restricted', 'Admin', 'Validation phase'),
('On Trial', 'Experiment on trial', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Testing', 'Pending', '2025-09-01', 'http://example.com/expstat20', 40, 'TRI001', 'Restricted', 'Admin', 'Trial phase'),
('Awaiting Data', 'Awaiting experiment data', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Operational', 'Pending', '2025-09-01', 'http://example.com/expstat21', 20, 'AWD001', 'Public', 'Admin', 'Awaiting data'),
('Closed', 'Experiment closed', 'Admin', '2025-09-01', NULL, NULL, 0, 2, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat22', 10, 'CLO001', 'Public', 'Admin', 'Closed experiment'),
('Analysis', 'Experiment in analysis', 'Admin', '2025-09-01', NULL, NULL, 1, 5, 'Analysis', 'Pending', '2025-09-01', 'http://example.com/expstat23', 30, 'ANA001', 'Restricted', 'Admin', 'Data analysis phase'),
('Setup', 'Experiment setup', 'Admin', '2025-09-01', NULL, NULL, 1, 4, 'Setup', 'Pending', '2025-09-01', 'http://example.com/expstat24', 25, 'SET001', 'Public', 'Admin', 'Setup phase'),
('Finalized', 'Experiment finalized', 'Admin', '2025-09-01', NULL, NULL, 0, 3, 'Operational', 'Approved', '2025-09-01', 'http://example.com/expstat25', 15, 'FIN001', 'Public', 'Admin', 'Finalized experiment');

-- 4. ParameterTypes (Auxiliary)
INSERT INTO ParameterTypes (ParameterName, Description, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, ParameterCategory, IsCritical, ApprovalStatus, LastValidatedDate, DocumentationURL, UsageFrequency, ParameterCode, ValidationNotes, StandardValue, DefaultUnit, PrecisionLevel, Notes)
VALUES
('Temperature', 'Reaction temperature', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 1, 'Approved', '2025-09-01', 'http://example.com/param1', 100, 'TEMP001', 'Validated', 300.0, '°C', 0.01, 'Critical parameter'),
('Pressure', 'Reaction pressure', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 1, 'Approved', '2025-09-01', 'http://example.com/param2', 90, 'PRES001', 'Validated', 1.0, 'bar', 0.01, 'Critical parameter'),
('Concentration', 'Reactant concentration', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param3', 80, 'CONC001', 'Validated', 0.1, 'mol/L', 0.001, 'Critical parameter'),
('pH', 'Solution pH', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 0, 'Approved', '2025-09-01', 'http://example.com/param4', 70, 'PH001', 'Validated', 7.0, 'pH', 0.1, 'Non-critical'),
('Flow Rate', 'Reactant flow rate', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param5', 60, 'FLOW001', 'Validated', 10.0, 'L/min', 0.01, 'Non-critical'),
('Catalyst Loading', 'Catalyst amount', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param6', 50, 'CATL001', 'Validated', 1.0, 'g/L', 0.001, 'Critical parameter'),
('Reaction Time', 'Duration of reaction', 'Admin', '2025-09-01', NULL, NULL, 'Temporal', 0, 'Approved', '2025-09-01', 'http://example.com/param7', 40, 'TIME001', 'Validated', 60.0, 'min', 1.0, 'Non-critical'),
('Stirring Speed', 'Mixing speed', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param8', 30, 'STIR001', 'Validated', 500.0, 'rpm', 1.0, 'Non-critical'),
('Viscosity', 'Solution viscosity', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param9', 20, 'VISC001', 'Validated', 1.0, 'cP', 0.01, 'Non-critical'),
('Density', 'Solution density', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param10', 25, 'DENS001', 'Validated', 1.0, 'g/cm³', 0.001, 'Non-critical'),
('Surface Tension', 'Surface tension', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param11', 15, 'SURF001', 'Validated', 30.0, 'mN/m', 0.01, 'Non-critical'),
('Heat Capacity', 'Heat capacity', 'Admin', '2025-09-01', NULL, NULL, 'Thermal', 0, 'Approved', '2025-09-01', 'http://example.com/param12', 10, 'HEAT001', 'Validated', 4.18, 'J/g°C', 0.01, 'Non-critical'),
('Thermal Conductivity', 'Thermal conductivity', 'Admin', '2025-09-01', NULL, NULL, 'Thermal', 0, 'Approved', '2025-09-01', 'http://example.com/param13', 10, 'THERM001', 'Validated', 0.6, 'W/mK', 0.001, 'Non-critical'),
('Molar Ratio', 'Reactant molar ratio', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param14', 30, 'MOLR001', 'Validated', 1.0, 'ratio', 0.01, 'Critical parameter'),
('Solubility', 'Solubility in solvent', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 0, 'Approved', '2025-09-01', 'http://example.com/param15', 20, 'SOLU001', 'Validated', 100.0, 'g/L', 0.01, 'Non-critical'),
('Particle Size', 'Particle size of solids', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param16', 15, 'PART001', 'Validated', 0.1, 'mm', 0.001, 'Non-critical'),
('Gas Flow', 'Gas flow rate', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param17', 25, 'GASF001', 'Validated', 5.0, 'L/min', 0.01, 'Non-critical'),
('Pressure Drop', 'Pressure drop across reactor', 'Admin', '2025-09-01', NULL, NULL, 'Physical', 0, 'Approved', '2025-09-01', 'http://example.com/param18', 10, 'PDROP001', 'Validated', 0.1, 'bar', 0.01, 'Non-critical'),
('Residence Time', 'Residence time in reactor', 'Admin', '2025-09-01', NULL, NULL, 'Temporal', 0, 'Approved', '2025-09-01', 'http://example.com/param19', 20, 'REST001', 'Validated', 10.0, 's', 0.1, 'Non-critical'),
('Catalyst Activity', 'Catalyst activity level', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param20', 30, 'CATA001', 'Validated', 90.0, '%', 0.1, 'Critical parameter'),
('Conversion Rate', 'Conversion rate of reactants', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param21', 40, 'CONV001', 'Validated', 80.0, '%', 0.1, 'Critical parameter'),
('Yield', 'Reaction yield', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param22', 50, 'YIELD001', 'Validated', 85.0, '%', 0.1, 'Critical parameter'),
('Selectivity', 'Reaction selectivity', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param23', 45, 'SEL001', 'Validated', 90.0, '%', 0.1, 'Critical parameter'),
('Purity', 'Product purity', 'Admin', '2025-09-01', NULL, NULL, 'Chemical', 1, 'Approved', '2025-09-01', 'http://example.com/param24', 40, 'PUR001', 'Validated', 99.0, '%', 0.01, 'Critical parameter'),
('Energy Input', 'Energy input to reaction', 'Admin', '2025-09-01', NULL, NULL, 'Thermal', 0, 'Approved', '2025-09-01', 'http://example.com/param25', 30, 'ENER001', 'Validated', 100.0, 'kJ/mol', 0.1, 'Non-critical');

-- 5. Units (Auxiliary)
INSERT INTO Units (UnitName, Description, UnitType, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsStandard, Precision, MinValue, MaxValue, ConversionBase, ApprovalStatus, LastValidatedDate, UnitCategory, DocumentationURL, UsageFrequency, Notes)
VALUES
('°C', 'Celsius', 'Temperature', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, -273.15, 1000.0, 'Kelvin', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit1', 100, 'Standard temperature unit'),
('bar', 'Pressure unit', 'Pressure', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 100.0, 'atm', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit2', 90, 'Standard pressure unit'),
('mol/L', 'Molar concentration', 'Concentration', 'Admin', '2025-09-01', NULL, NULL, 1, 0.001, 0.0, 10.0, 'mol/L', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit3', 80, 'Standard concentration unit'),
('pH', 'pH scale', 'Chemical', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 14.0, 'pH', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit4', 70, 'pH measurement'),
('L/min', 'Liters per minute', 'Flow Rate', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 1000.0, 'm³/s', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit5', 60, 'Flow rate unit'),
('g/L', 'Grams per liter', 'Concentration', 'Admin', '2025-09-01', NULL, NULL, 1, 0.001, 0.0, 1000.0, 'kg/m³', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit6', 50, 'Catalyst loading unit'),
('min', 'Minutes', 'Time', 'Admin', '2025-09-01', NULL, NULL, 1, 1.0, 0.0, 1440.0, 's', 'Approved', '2025-09-01', 'Temporal', 'http://example.com/unit7', 40, 'Time duration unit'),
('rpm', 'Revolutions per minute', 'Speed', 'Admin', '2025-09-01', NULL, NULL, 1, 1.0, 0.0, 10000.0, 'Hz', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit8', 30, 'Stirring speed unit'),
('cP', 'Centipoise', 'Viscosity', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 1000.0, 'Pa·s', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit9', 20, 'Viscosity unit'),
('g/cm³', 'Grams per cubic centimeter', 'Density', 'Admin', '2025-09-01', NULL, NULL, 1, 0.001, 0.0, 10.0, 'kg/m³', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit10', 25, 'Density unit'),
('mN/m', 'Millinewtons per meter', 'Surface Tension', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 100.0, 'N/m', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit11', 15, 'Surface tension unit'),
('J/g°C', 'Joules per gram per Celsius', 'Heat Capacity', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 10.0, 'J/kgK', 'Approved', '2025-09-01', 'Thermal', 'http://example.com/unit12', 10, 'Heat capacity unit'),
('W/mK', 'Watts per meter per Kelvin', 'Thermal Conductivity', 'Admin', '2025-09-01', NULL, NULL, 1, 0.001, 0.0, 100.0, 'W/mK', 'Approved', '2025-09-01', 'Thermal', 'http://example.com/unit13', 10, 'Thermal conductivity unit'),
('ratio', 'Molar ratio', 'Ratio', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 10.0, 'ratio', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit14', 30, 'Molar ratio unit'),
('g/L', 'Grams per liter (solubility)', 'Solubility', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 1000.0, 'kg/m³', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit15', 20, 'Solubility unit'),
('mm', 'Millimeters', 'Length', 'Admin', '2025-09-01', NULL, NULL, 1, 0.001, 0.0, 100.0, 'm', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit16', 15, 'Particle size unit'),
('L/min', 'Liters per minute (gas)', 'Gas Flow', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 1000.0, 'm³/s', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit17', 25, 'Gas flow unit'),
('bar', 'Pressure drop unit', 'Pressure', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 10.0, 'Pa', 'Approved', '2025-09-01', 'Physical', 'http://example.com/unit18', 10, 'Pressure drop unit'),
('s', 'Seconds', 'Time', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 3600.0, 's', 'Approved', '2025-09-01', 'Temporal', 'http://example.com/unit19', 20, 'Residence time unit'),
('%', 'Percentage (activity)', 'Percentage', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 100.0, '%', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit20', 30, 'Catalyst activity unit'),
('%', 'Percentage (conversion)', 'Percentage', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 100.0, '%', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit21', 40, 'Conversion rate unit'),
('%', 'Percentage (yield)', 'Percentage', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 100.0, '%', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit22', 50, 'Yield unit'),
('%', 'Percentage (selectivity)', 'Percentage', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 100.0, '%', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit23', 45, 'Selectivity unit'),
('%', 'Percentage (purity)', 'Percentage', 'Admin', '2025-09-01', NULL, NULL, 1, 0.01, 0.0, 100.0, '%', 'Approved', '2025-09-01', 'Chemical', 'http://example.com/unit24', 40, 'Purity unit'),
('kJ/mol', 'Kilojoules per mole', 'Energy', 'Admin', '2025-09-01', NULL, NULL, 1, 0.1, 0.0, 1000.0, 'J/mol', 'Approved', '2025-09-01', 'Thermal', 'http://example.com/unit25', 30, 'Energy input unit');

-- 6. Suppliers (Auxiliary)
INSERT INTO Suppliers (Name, Contact, Address, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, ContactEmail, ContactPhone, SupplierRating, ContractStartDate, ContractEndDate, ApprovalStatus, LastValidatedDate, SupplierType, PaymentTerms, Notes)
VALUES
('ChemCorp', 'John Doe', '123 Chem St, Houston, TX', 'Admin', '2025-09-01', NULL, NULL, 'contact@chemcorp.com', '123-456-7890', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Primary supplier'),
('PetroChem', 'Jane Smith', '456 Petro Ave, Baton Rouge, LA', 'Admin', '2025-09-01', NULL, NULL, 'jane@petrochem.com', '234-567-8901', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'High-quality catalysts'),
('RefineTech', 'Mike Brown', '789 Refinery Rd, Galveston, TX', 'Admin', '2025-09-01', NULL, NULL, 'mike@refinetech.com', '345-678-9012', 3, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Equipment', 'Net 30', 'Equipment supplier'),
('ChemSupply', 'Sarah Johnson', '101 Chem Way, Pasadena, TX', 'Admin', '2025-09-01', NULL, NULL, 'sarah@chemsupply.com', '456-789-0123', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Reactant supplier'),
('IndustChem', 'Tom Wilson', '202 Indus St, Freeport, TX', 'Admin', '2025-09-01', NULL, NULL, 'tom@industchem.com', '567-890-1234', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'Bulk supplier'),
('SynthoChem', 'Lisa Davis', '303 Synth Rd, Corpus Christi, TX', 'Admin', '2025-09-01', NULL, NULL, 'lisa@synthochem.com', '678-901-2345', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Specialty chemicals'),
('CatalystCorp', 'David Lee', '404 Cat St, Houston, TX', 'Admin', '2025-09-01', NULL, NULL, 'david@catalystcorp.com', '789-012-3456', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Catalyst', 'Net 30', 'Catalyst supplier'),
('PetroSupply', 'Emily Clark', '505 Petro Rd, Beaumont, TX', 'Admin', '2025-09-01', NULL, NULL, 'emily@petrosupply.com', '890-123-4567', 3, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'General supplier'),
('RefChem', 'Robert Harris', '606 Ref St, Port Arthur, TX', 'Admin', '2025-09-01', NULL, NULL, 'robert@refchem.com', '901-234-5678', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Refinery chemicals'),
('ChemInd', 'Laura Martinez', '707 Chem Ave, Deer Park, TX', 'Admin', '2025-09-01', NULL, NULL, 'laura@chemind.com', '012-345-6789', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Industrial supplier'),
('SynChem', 'James White', '808 Syn Rd, Texas City, TX', 'Admin', '2025-09-01', NULL, NULL, 'james@synchem.com', '123-456-7891', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'Synthetic chemicals'),
('CatTech', 'Mary Thompson', '909 Cat Way, Houston, TX', 'Admin', '2025-09-01', NULL, NULL, 'mary@cattech.com', '234-567-8902', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Catalyst', 'Net 30', 'Catalyst specialist'),
('PetroInd', 'Steven Walker', '1010 Petro St, Pasadena, TX', 'Admin', '2025-09-01', NULL, NULL, 'steven@petroind.com', '345-678-9013', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Petrochemical supplier'),
('ChemTech', 'Jennifer Adams', '1111 Chem Rd, Freeport, TX', 'Admin', '2025-09-01', NULL, NULL, 'jennifer@chemtech.com', '456-789-0124', 3, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'Chemical technology'),
('RefSupply', 'Michael Young', '1212 Ref Ave, Corpus Christi, TX', 'Admin', '2025-09-01', NULL, NULL, 'michael@refsupply.com', '567-890-1235', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Refinery supplier'),
('IndustSupply', 'Patricia King', '1313 Indus St, Beaumont, TX', 'Admin', '2025-09-01', NULL, NULL, 'patricia@industsupply.com', '678-901-2346', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Industrial supplier'),
('ChemSol', 'Richard Green', '1414 Chem Way, Port Arthur, TX', 'Admin', '2025-09-01', NULL, NULL, 'richard@chemsol.com', '789-012-3457', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'Solution provider'),
('PetroTech', 'Susan Hall', '1515 Petro Rd, Houston, TX', 'Admin', '2025-09-01', NULL, NULL, 'susan@petrotech.com', '890-123-4568', 3, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Petrochemical technology'),
('CatSupply', 'William Scott', '1616 Cat St, Texas City, TX', 'Admin', '2025-09-01', NULL, NULL, 'william@catsupply.com', '901-234-5679', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Catalyst', 'Net 30', 'Catalyst supplier'),
('RefInd', 'Elizabeth Turner', '1717 Ref Way, Deer Park, TX', 'Admin', '2025-09-01', NULL, NULL, 'elizabeth@refind.com', '012-345-6780', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Refinery industry'),
('ChemProd', 'Thomas Allen', '1818 Chem Rd, Pasadena, TX', 'Admin', '2025-09-01', NULL, NULL, 'thomas@chemprod.com', '123-456-7892', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'Chemical products'),
('SynSupply', 'Nancy Carter', '1919 Syn St, Houston, TX', 'Admin', '2025-09-01', NULL, NULL, 'nancy@synsupply.com', '234-567-8903', 3, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Synthetic supplier'),
('PetroSol', 'Charles Moore', '2020 Petro Ave, Freeport, TX', 'Admin', '2025-09-01', NULL, NULL, 'charles@petrosol.com', '345-678-9014', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Petrochemical solutions'),
('ChemEng', 'Linda Parker', '2121 Chem Way, Beaumont, TX', 'Admin', '2025-09-01', NULL, NULL, 'linda@chemeng.com', '456-789-0125', 5, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 30', 'Engineering chemicals'),
('RefTech', 'Daniel Evans', '2222 Ref Rd, Corpus Christi, TX', 'Admin', '2025-09-01', NULL, NULL, 'daniel@reftech.com', '567-890-1236', 4, '2025-01-01', '2026-01-01', 'Approved', '2025-09-01', 'Chemical', 'Net 45', 'Refinery technology');

-- 7. ReportTemplates (Auxiliary)
INSERT INTO ReportTemplates (TemplateName, Description, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, ReportType, IsActive, PriorityLevel, ApprovalStatus, LastValidatedDate, DocumentationURL, TemplateCategory, UsageFrequency, TemplateCode, OutputFormat, Notes)
VALUES
('Yield Report', 'Reaction yield summary', 'Admin', '2025-09-01', NULL, NULL, 'Summary', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp1', 'Performance', 100, 'YLD001', 'PDF', 'Standard yield report'),
('Catalyst Performance', 'Catalyst performance analysis', 'Admin', '2025-09-01', NULL, NULL, 'Analysis', 1, 6, 'Approved', '2025-09-01', 'http://example.com/temp2', 'Performance', 80, 'CATP001', 'PDF', 'Catalyst report'),
('Condition Optimization', 'Optimal condition report', 'Admin', '2025-09-01', NULL, NULL, 'Optimization', 1, 7, 'Approved', '2025-09-01', 'http://example.com/temp3', 'Optimization', 70, 'OPT001', 'PDF', 'Optimization report'),
('Monthly Summary', 'Monthly experiment summary', 'Admin', '2025-09-01', NULL, NULL, 'Summary', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp4', 'Summary', 60, 'MON001', 'Excel', 'Monthly report'),
('Safety Report', 'Safety compliance report', 'Admin', '2025-09-01', NULL, NULL, 'Safety', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp5', 'Safety', 50, 'SAF001', 'PDF', 'Safety report'),
('Equipment Usage', 'Equipment usage report', 'Admin', '2025-09-01', NULL, NULL, 'Equipment', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp6', 'Equipment', 40, 'EQU001', 'Excel', 'Equipment usage'),
('Researcher Activity', 'Researcher activity report', 'Admin', '2025-09-01', NULL, NULL, 'Personnel', 1, 3, 'Approved', '2025-09-01', 'http://example.com/temp7', 'Personnel', 30, 'RES001', 'PDF', 'Researcher report'),
('Reaction Summary', 'Reaction overview report', 'Admin', '2025-09-01', NULL, NULL, 'Summary', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp8', 'Summary', 50, 'RXN001', 'PDF', 'Reaction overview'),
('Cost Analysis', 'Cost analysis report', 'Admin', '2025-09-01', NULL, NULL, 'Financial', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp9', 'Financial', 40, 'COST001', 'Excel', 'Cost analysis'),
('Process Efficiency', 'Process efficiency report', 'Admin', '2025-09-01', NULL, NULL, 'Performance', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp10', 'Performance', 45, 'EFF001', 'PDF', 'Efficiency report'),
('Compliance Report', 'Regulatory compliance report', 'Admin', '2025-09-01', NULL, NULL, 'Compliance', 1, 6, 'Approved', '2025-09-01', 'http://example.com/temp11', 'Compliance', 35, 'COMP001', 'PDF', 'Compliance report'),
('Experiment Trends', 'Experiment trend analysis', 'Admin', '2025-09-01', NULL, NULL, 'Analysis', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp12', 'Analysis', 50, 'TREND001', 'Excel', 'Trend analysis'),
('Material Usage', 'Material usage report', 'Admin', '2025-09-01', NULL, NULL, 'Material', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp13', 'Material', 40, 'MAT001', 'Excel', 'Material usage'),
('Quality Control', 'Quality control report', 'Admin', '2025-09-01', NULL, NULL, 'Quality', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp14', 'Quality', 45, 'QC001', 'PDF', 'Quality control'),
('Safety Audit', 'Safety audit report', 'Admin', '2025-09-01', NULL, NULL, 'Safety', 1, 6, 'Approved', '2025-09-01', 'http://example.com/temp15', 'Safety', 35, 'SAUD001', 'PDF', 'Safety audit'),
('Performance Metrics', 'Performance metrics report', 'Admin', '2025-09-01', NULL, NULL, 'Performance', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp16', 'Performance', 50, 'PERF001', 'Excel', 'Performance metrics'),
('Reaction Efficiency', 'Reaction efficiency report', 'Admin', '2025-09-01', NULL, NULL, 'Performance', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp17', 'Performance', 45, 'REFF001', 'PDF', 'Reaction efficiency'),
('Catalyst Usage', 'Catalyst usage report', 'Admin', '2025-09-01', NULL, NULL, 'Catalyst', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp18', 'Catalyst', 40, 'CATU001', 'Excel', 'Catalyst usage'),
('Experiment Summary', 'Experiment summary report', 'Admin', '2025-09-01', NULL, NULL, 'Summary', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp19', 'Summary', 50, 'EXPS001', 'PDF', 'Experiment summary'),
('Process Optimization', 'Process optimization report', 'Admin', '2025-09-01', NULL, NULL, 'Optimization', 1, 6, 'Approved', '2025-09-01', 'http://example.com/temp20', 'Optimization', 45, 'POPT001', 'PDF', 'Process optimization'),
('Yield Trends', 'Yield trend analysis', 'Admin', '2025-09-01', NULL, NULL, 'Analysis', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp21', 'Analysis', 50, 'YTREND001', 'Excel', 'Yield trends'),
('Safety Metrics', 'Safety metrics report', 'Admin', '2025-09-01', NULL, NULL, 'Safety', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp22', 'Safety', 40, 'SMET001', 'PDF', 'Safety metrics'),
('Equipment Efficiency', 'Equipment efficiency report', 'Admin', '2025-09-01', NULL, NULL, 'Equipment', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp23', 'Equipment', 35, 'EEFF001', 'Excel', 'Equipment efficiency'),
('Material Efficiency', 'Material efficiency report', 'Admin', '2025-09-01', NULL, NULL, 'Material', 1, 4, 'Approved', '2025-09-01', 'http://example.com/temp24', 'Material', 40, 'MEFF001', 'Excel', 'Material efficiency'),
('Compliance Summary', 'Compliance summary report', 'Admin', '2025-09-01', NULL, NULL, 'Compliance', 1, 5, 'Approved', '2025-09-01', 'http://example.com/temp25', 'Compliance', 45, 'CSUM001', 'PDF', 'Compliance summary');

-- 8. DataSources (Auxiliary)
INSERT INTO DataSources (SourceName, Description, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, SourceType, IsActive, ApprovalStatus, LastValidatedDate, DocumentationURL, SourceReliability, SourceOwner, SourceContact, UsageFrequency, SourceCode, Notes)
VALUES
('Lab Experiment', 'Laboratory experiment data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source1', 5, 'Lab Team', 'lab@refinery.com', 100, 'LAB001', 'Primary data source'),
('Simulation', 'Simulation data', 'Admin', '2025-09-01', NULL, NULL, 'Simulation', 1, 'Approved', '2025-09-01', 'http://example.com/source2', 4, 'Sim Team', 'sim@refinery.com', 80, 'SIM001', 'Simulated data'),
('Pilot Plant', 'Pilot plant data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source3', 5, 'Pilot Team', 'pilot@refinery.com', 70, 'PIL001', 'Pilot plant data'),
('Historical Data', 'Historical experiment data', 'Admin', '2025-09-01', NULL, NULL, 'Historical', 1, 'Approved', '2025-09-01', 'http://example.com/source4', 3, 'Archive Team', 'archive@refinery.com', 50, 'HIST001', 'Historical records'),
('Vendor Data', 'Vendor-supplied data', 'Admin', '2025-09-01', NULL, NULL, 'External', 1, 'Approved', '2025-09-01', 'http://example.com/source5', 4, 'Vendor Team', 'vendor@refinery.com', 40, 'VEND001', 'Vendor data'),
('Literature', 'Published literature data', 'Admin', '2025-09-01', NULL, NULL, 'External', 1, 'Approved', '2025-09-01', 'http://example.com/source6', 3, 'Research Team', 'research@refinery.com', 30, 'LIT001', 'Literature data'),
('Field Test', 'Field test data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source7', 5, 'Field Team', 'field@refinery.com', 60, 'FIELD001', 'Field test data'),
('Computational Model', 'Computational model data', 'Admin', '2025-09-01', NULL, NULL, 'Simulation', 1, 'Approved', '2025-09-01', 'http://example.com/source8', 4, 'Comp Team', 'comp@refinery.com', 50, 'COMP001', 'Model data'),
('Lab Simulation', 'Lab simulation data', 'Admin', '2025-09-01', NULL, NULL, 'Simulation', 1, 'Approved', '2025-09-01', 'http://example.com/source9', 4, 'Lab Team', 'lab@refinery.com', 45, 'LSIM001', 'Lab simulation'),
('Pilot Simulation', 'Pilot simulation data', 'Admin', '2025-09-01', NULL, NULL, 'Simulation', 1, 'Approved', '2025-09-01', 'http://example.com/source10', 4, 'Pilot Team', 'pilot@refinery.com', 40, 'PSIM001', 'Pilot simulation'),
('External Lab', 'External lab data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source11', 4, 'Ext Lab Team', 'extlab@refinery.com', 35, 'EXTL001', 'External lab data'),
('Industry Standard', 'Industry standard data', 'Admin', '2025-09-01', NULL, NULL, 'External', 1, 'Approved', '2025-09-01', 'http://example.com/source12', 3, 'Industry Team', 'industry@refinery.com', 30, 'IND001', 'Industry standards'),
('Test Reactor', 'Test reactor data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source13', 5, 'Reactor Team', 'reactor@refinery.com', 50, 'REAC001', 'Test reactor data'),
('Process Data', 'Process plant data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source14', 5, 'Process Team', 'process@refinery.com', 60, 'PROC001', 'Process plant data'),
('Benchmark Data', 'Benchmarking data', 'Admin', '2025-09-01', NULL, NULL, 'External', 1, 'Approved', '2025-09-01', 'http://example.com/source15', 4, 'Bench Team', 'bench@refinery.com', 40, 'BENCH001', 'Benchmark data'),
('Quality Control', 'Quality control data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source16', 5, 'QC Team', 'qc@refinery.com', 50, 'QC001', 'QC data'),
('Safety Data', 'Safety test data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source17', 5, 'Safety Team', 'safety@refinery.com', 45, 'SAF001', 'Safety test data'),
('Prototype Data', 'Prototype experiment data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source18', 4, 'Proto Team', 'proto@refinery.com', 40, 'PROTO001', 'Prototype data'),
('Validation Data', 'Validation experiment data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source19', 5, 'Val Team', 'val@refinery.com', 50, 'VAL001', 'Validation data'),
('Scale-Up Data', 'Scale-up experiment data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source20', 5, 'Scale Team', 'scale@refinery.com', 60, 'SCALE001', 'Scale-up data'),
('Reference Data', 'Reference experiment data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source21', 4, 'Ref Team', 'ref@refinery.com', 40, 'REF001', 'Reference data'),
('Test Data', 'General test data', 'Admin', '2025-09-01', NULL, NULL, 'Experimental', 1, 'Approved', '2025-09-01', 'http://example.com/source22', 5, 'Test Team', 'test@refinery.com', 50, 'TEST001', 'Test data'),
('Model Data', 'Model-generated data', 'Admin', '2025-09-01', NULL, NULL, 'Simulation', 1, 'Approved', '2025-09-01', 'http://example.com/source23', 4, 'Model Team', 'model@refinery.com', 45, 'MODEL001', 'Model data'),
('External Reference', 'External reference data', 'Admin', '2025-09-01', NULL, NULL, 'External', 1, 'Approved', '2025-09-01', 'http://example.com/source24', 3, 'Ext Team', 'ext@refinery.com', 30, 'EXT001', 'External reference'),
('Compliance Data', 'Compliance test data', 'Admin', '2025-09-01', NULL, NULL, 'Compliance', 1, 'Approved', '2025-09-01', 'http://example.com/source25', 5, 'Comp Team', 'comp@refinery.com', 40, 'COMP001', 'Compliance data');

USE ChemKineticsDB;
GO

-- 9. Locations (Auxiliary)
INSERT INTO Locations (RefineryName, Site, Country, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Latitude, Longitude, FacilityType, Capacity, OperationalStatus, ContactPerson, ContactEmail, ContactPhone, ApprovalStatus, LastValidatedDate, Notes)
VALUES
('Houston Refinery', 'Houston', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.7604, -95.3698, 'Refinery', 500000.0, 'Operational', 'John Smith', 'john@houstonref.com', '123-456-7890', 'Approved', '2025-09-01', 'Main refinery'),
('Baton Rouge Plant', 'Baton Rouge', 'USA', 'Admin', '2025-09-01', NULL, NULL, 30.4515, -91.1871, 'Refinery', 400000.0, 'Operational', 'Jane Doe', 'jane@batonref.com', '234-567-8901', 'Approved', '2025-09-01', 'Secondary refinery'),
('Galveston Facility', 'Galveston', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.3013, -94.7977, 'Pilot Plant', 100000.0, 'Operational', 'Mike Brown', 'mike@galvref.com', '345-678-9012', 'Approved', '2025-09-01', 'Pilot facility'),
('Pasadena Refinery', 'Pasadena', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.6911, -95.2091, 'Refinery', 600000.0, 'Operational', 'Sarah Johnson', 'sarah@pasadenaref.com', '456-789-0123', 'Approved', '2025-09-01', 'Large refinery'),
('Freeport Plant', 'Freeport', 'USA', 'Admin', '2025-09-01', NULL, NULL, 28.9541, -95.3597, 'Refinery', 450000.0, 'Operational', 'Tom Wilson', 'tom@freeportref.com', '567-890-1234', 'Approved', '2025-09-01', 'Coastal refinery'),
('Corpus Christi Ref', 'Corpus Christi', 'USA', 'Admin', '2025-09-01', NULL, NULL, 27.8006, -97.3964, 'Refinery', 550000.0, 'Operational', 'Lisa Davis', 'lisa@corpusref.com', '678-901-2345', 'Approved', '2025-09-01', 'Major refinery'),
('Beaumont Facility', 'Beaumont', 'USA', 'Admin', '2025-09-01', NULL, NULL, 30.0802, -94.1266, 'Refinery', 500000.0, 'Operational', 'David Lee', 'david@beaumontref.com', '789-012-3456', 'Approved', '2025-09-01', 'Refinery'),
('Port Arthur Plant', 'Port Arthur', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.8850, -93.9399, 'Refinery', 400000.0, 'Operational', 'Emily Clark', 'emily@portarthurref.com', '890-123-4567', 'Approved', '2025-09-01', 'Refinery'),
('Deer Park Refinery', 'Deer Park', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.7052, -95.1238, 'Refinery', 450000.0, 'Operational', 'Robert Harris', 'robert@deerparkref.com', '901-234-5678', 'Approved', '2025-09-01', 'Refinery'),
('Texas City Plant', 'Texas City', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.3838, -94.9027, 'Refinery', 500000.0, 'Operational', 'Laura Martinez', 'laura@texascityref.com', '012-345-6789', 'Approved', '2025-09-01', 'Refinery'),
('Baytown Refinery', 'Baytown', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.7355, -94.9774, 'Refinery', 600000.0, 'Operational', 'James White', 'james@baytownref.com', '123-456-7891', 'Approved', '2025-09-01', 'Large refinery'),
('Lake Charles Plant', 'Lake Charles', 'USA', 'Admin', '2025-09-01', NULL, NULL, 30.2266, -93.2174, 'Refinery', 400000.0, 'Operational', 'Mary Thompson', 'mary@lakecharlesref.com', '234-567-8902', 'Approved', '2025-09-01', 'Refinery'),
('Mobile Facility', 'Mobile', 'USA', 'Admin', '2025-09-01', NULL, NULL, 30.6954, -88.0431, 'Pilot Plant', 100000.0, 'Operational', 'Steven Walker', 'steven@mobileref.com', '345-678-9013', 'Approved', '2025-09-01', 'Pilot facility'),
('New Orleans Ref', 'New Orleans', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.9511, -90.0715, 'Refinery', 450000.0, 'Operational', 'Jennifer Adams', 'jennifer@neworleansref.com', '456-789-0124', 'Approved', '2025-09-01', 'Refinery'),
('Tulsa Plant', 'Tulsa', 'USA', 'Admin', '2025-09-01', NULL, NULL, 36.1540, -95.9928, 'Refinery', 400000.0, 'Operational', 'Michael Young', 'michael@tulsaref.com', '567-890-1235', 'Approved', '2025-09-01', 'Refinery'),
('Cushing Facility', 'Cushing', 'USA', 'Admin', '2025-09-01', NULL, NULL, 35.9851, -96.7670, 'Storage', 200000.0, 'Operational', 'Patricia King', 'patricia@cushingref.com', '678-901-2346', 'Approved', '2025-09-01', 'Storage facility'),
('Midland Refinery', 'Midland', 'USA', 'Admin', '2025-09-01', NULL, NULL, 32.0004, -102.0779, 'Refinery', 450000.0, 'Operational', 'Richard Green', 'richard@midlandref.com', '789-012-3457', 'Approved', '2025-09-01', 'Refinery'),
('Odessa Plant', 'Odessa', 'USA', 'Admin', '2025-09-01', NULL, NULL, 31.8457, -102.3676, 'Refinery', 400000.0, 'Operational', 'Susan Hall', 'susan@odessaref.com', '890-123-4568', 'Approved', '2025-09-01', 'Refinery'),
('El Paso Facility', 'El Paso', 'USA', 'Admin', '2025-09-01', NULL, NULL, 31.7619, -106.4850, 'Refinery', 350000.0, 'Operational', 'William Scott', 'william@elpasoref.com', '901-234-5679', 'Approved', '2025-09-01', 'Refinery'),
('San Antonio Ref', 'San Antonio', 'USA', 'Admin', '2025-09-01', NULL, NULL, 29.4241, -98.4936, 'Refinery', 400000.0, 'Operational', 'Elizabeth Turner', 'elizabeth@sanantonioref.com', '012-345-6780', 'Approved', '2025-09-01', 'Refinery'),
('Aransas Pass Plant', 'Aransas Pass', 'USA', 'Admin', '2025-09-01', NULL, NULL, 27.9095, -97.1500, 'Refinery', 350000.0, 'Operational', 'Thomas Allen', 'thomas@aransasref.com', '123-456-7892', 'Approved', '2025-09-01', 'Refinery'),
('Port Lavaca Ref', 'Port Lavaca', 'USA', 'Admin', '2025-09-01', NULL, NULL, 28.6150, -96.6261, 'Refinery', 400000.0, 'Operational', 'Nancy Carter', 'nancy@portlavacaref.com', '234-567-8903', 'Approved', '2025-09-01', 'Refinery'),
('Victoria Plant', 'Victoria', 'USA', 'Admin', '2025-09-01', NULL, NULL, 28.8053, -97.0036, 'Refinery', 350000.0, 'Operational', 'Charles Moore', 'charles@victoriaref.com', '345-678-9014', 'Approved', '2025-09-01', 'Refinery'),
('Brownsville Facility', 'Brownsville', 'USA', 'Admin', '2025-09-01', NULL, NULL, 25.9018, -97.4975, 'Refinery', 300000.0, 'Operational', 'Linda Parker', 'linda@brownsvilleref.com', '456-789-0125', 'Approved', '2025-09-01', 'Refinery'),
('Laredo Refinery', 'Laredo', 'USA', 'Admin', '2025-09-01', NULL, NULL, 27.5306, -99.4803, 'Refinery', 350000.0, 'Operational', 'Daniel Evans', 'daniel@laredoref.com', '567-890-1236', 'Approved', '2025-09-01', 'Refinery');

-- 10. Researchers (Auxiliary)
INSERT INTO Researchers (Name, Department, Contact, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, EmployeeID, ExpertiseArea, YearsExperience, Certification, SecurityClearance, ApprovalStatus, LastValidatedDate, OfficeLocation, ContactPhone, Notes)
VALUES
('John Smith', 'R&D', 'john.smith@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP001', 'Catalysis', 10, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Houston', '123-456-7890', 'Lead researcher'),
('Jane Doe', 'Process Engineering', 'jane.doe@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP002', 'Polymerization', 8, 'MSc ChemEng', 'Level 2', 'Approved', '2025-09-01', 'Baton Rouge', '234-567-8901', 'Process specialist'),
('Mike Brown', 'Analytical Chemistry', 'mike.brown@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP003', 'Spectroscopy', 12, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Galveston', '345-678-9012', 'Analytical expert'),
('Sarah Johnson', 'R&D', 'sarah.johnson@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP004', 'Kinetics', 7, 'MSc Chem', 'Level 2', 'Approved', '2025-09-01', 'Pasadena', '456-789-0123', 'Kinetics specialist'),
('Tom Wilson', 'Process Engineering', 'tom.wilson@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP005', 'Cracking', 9, 'PhD ChemEng', 'Level 1', 'Approved', '2025-09-01', 'Freeport', '567-890-1234', 'Cracking expert'),
('Lisa Davis', 'R&D', 'lisa.davis@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP006', 'Hydrogenation', 6, 'MSc Chem', 'Level 2', 'Approved', '2025-09-01', 'Corpus Christi', '678-901-2345', 'Hydrogenation specialist'),
('David Lee', 'Analytical Chemistry', 'david.lee@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP007', 'Chromatography', 11, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Beaumont', '789-012-3456', 'Analytical expert'),
('Emily Clark', 'Process Engineering', 'emily.clark@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP008', 'Reforming', 8, 'MSc ChemEng', 'Level 2', 'Approved', '2025-09-01', 'Port Arthur', '890-123-4567', 'Reforming specialist'),
('Robert Harris', 'R&D', 'robert.harris@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP009', 'Catalysis', 10, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Deer Park', '901-234-5678', 'Catalyst expert'),
('Laura Martinez', 'Analytical Chemistry', 'laura.martinez@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP010', 'Spectroscopy', 7, 'MSc Chem', 'Level 2', 'Approved', '2025-09-01', 'Texas City', '012-345-6789', 'Analytical specialist'),
('James White', 'R&D', 'james.white@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP011', 'Polymerization', 9, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Baytown', '123-456-7891', 'Polymer expert'),
('Mary Thompson', 'Process Engineering', 'mary.thompson@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP012', 'Cracking', 8, 'MSc ChemEng', 'Level 2', 'Approved', '2025-09-01', 'Lake Charles', '234-567-8902', 'Cracking specialist'),
('Steven Walker', 'R&D', 'steven.walker@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP013', 'Hydrogenation', 6, 'MSc Chem', 'Level 2', 'Approved', '2025-09-01', 'Mobile', '345-678-9013', 'Hydrogenation expert'),
('Jennifer Adams', 'Analytical Chemistry', 'jennifer.adams@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP014', 'Chromatography', 10, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'New Orleans', '456-789-0124', 'Analytical expert'),
('Michael Young', 'R&D', 'michael.young@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP015', 'Catalysis', 9, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Tulsa', '567-890-1235', 'Catalyst specialist'),
('Patricia King', 'Process Engineering', 'patricia.king@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP016', 'Reforming', 7, 'MSc ChemEng', 'Level 2', 'Approved', '2025-09-01', 'Cushing', '678-901-2346', 'Reforming expert'),
('Richard Green', 'R&D', 'richard.green@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP017', 'Polymerization', 8, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Midland', '789-012-3457', 'Polymer specialist'),
('Susan Hall', 'Analytical Chemistry', 'susan.hall@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP018', 'Spectroscopy', 6, 'MSc Chem', 'Level 2', 'Approved', '2025-09-01', 'Odessa', '890-123-4568', 'Analytical specialist'),
('William Scott', 'R&D', 'william.scott@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP019', 'Cracking', 10, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'El Paso', '901-234-5679', 'Cracking expert'),
('Elizabeth Turner', 'Process Engineering', 'elizabeth.turner@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP020', 'Hydrogenation', 7, 'MSc ChemEng', 'Level 2', 'Approved', '2025-09-01', 'San Antonio', '012-345-6780', 'Hydrogenation specialist'),
('Thomas Allen', 'R&D', 'thomas.allen@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP021', 'Catalysis', 9, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Aransas Pass', '123-456-7892', 'Catalyst expert'),
('Nancy Carter', 'Analytical Chemistry', 'nancy.carter@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP022', 'Chromatography', 8, 'MSc Chem', 'Level 2', 'Approved', '2025-09-01', 'Port Lavaca', '234-567-8903', 'Analytical specialist'),
('Charles Moore', 'R&D', 'charles.moore@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP023', 'Polymerization', 7, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Victoria', '345-678-9014', 'Polymer expert'),
('Linda Parker', 'Process Engineering', 'linda.parker@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP024', 'Reforming', 6, 'MSc ChemEng', 'Level 2', 'Approved', '2025-09-01', 'Brownsville', '456-789-0125', 'Reforming specialist'),
('Daniel Evans', 'R&D', 'daniel.evans@refinery.com', 'Admin', '2025-09-01', NULL, NULL, 'EMP025', 'Cracking', 9, 'PhD Chem', 'Level 1', 'Approved', '2025-09-01', 'Laredo', '567-890-1236', 'Cracking expert');

-- 11. Reactions (Core)
INSERT INTO Reactions (ReactionTypeID, ReactionName, Description, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsActive, EquilibriumConstant, RateConstant, TemperatureRangeMin, TemperatureRangeMax, PressureRangeMin, PressureRangeMax, SafetyNotes, ProcessCategory, ApprovalStatus, LastValidatedDate, DocumentationURL, PriorityLevel)
VALUES
(1, 'Catalytic Cracking', 'Hydrocarbon cracking reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.234, 0.567, 300.0, 500.0, 1.0, 10.0, 'Handle with care', 'Cracking', 'Approved', '2025-09-01', 'http://example.com/rxn1', 7),
(2, 'Polymerization', 'Polymer formation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.345, 0.678, 200.0, 400.0, 2.0, 15.0, 'Monitor temperature', 'Polymerization', 'Approved', '2025-09-01', 'http://example.com/rxn2', 6),
(3, 'Hydrogenation', 'Hydrogen addition reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.456, 0.789, 250.0, 450.0, 5.0, 20.0, 'High pressure caution', 'Hydrogenation', 'Approved', '2025-09-01', 'http://example.com/rxn3', 5),
(4, 'Reforming', 'Catalytic reforming reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 3.567, 0.890, 400.0, 600.0, 10.0, 30.0, 'Ensure ventilation', 'Reforming', 'Approved', '2025-09-01', 'http://example.com/rxn4', 6),
(5, 'Oxidation', 'Oxidation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.678, 0.901, 300.0, 500.0, 1.0, 10.0, 'Oxygen hazard', 'Oxidation', 'Approved', '2025-09-01', 'http://example.com/rxn5', 5),
(6, 'Isomerization', 'Isomer rearrangement reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.789, 0.912, 200.0, 400.0, 2.0, 15.0, 'Stable conditions required', 'Isomerization', 'Approved', '2025-09-01', 'http://example.com/rxn6', 4),
(7, 'Alkylation', 'Alkyl group addition reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.890, 0.923, 250.0, 450.0, 5.0, 20.0, 'Corrosive materials', 'Alkylation', 'Approved', '2025-09-01', 'http://example.com/rxn7', 5),
(8, 'Dehydrogenation', 'Hydrogen removal reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 3.901, 0.934, 300.0, 500.0, 1.0, 10.0, 'High temperature caution', 'Dehydrogenation', 'Approved', '2025-09-01', 'http://example.com/rxn8', 6),
(9, 'Esterification', 'Ester formation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.012, 0.945, 200.0, 400.0, 2.0, 15.0, 'Acid handling', 'Esterification', 'Approved', '2025-09-01', 'http://example.com/rxn9', 4),
(10, 'Hydrolysis', 'Water-mediated cleavage reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.123, 0.956, 250.0, 450.0, 5.0, 20.0, 'Water safety', 'Hydrolysis', 'Approved', '2025-09-01', 'http://example.com/rxn10', 5),
(11, 'Condensation', 'Condensation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.234, 0.967, 300.0, 500.0, 1.0, 10.0, 'Monitor byproducts', 'Condensation', 'Approved', '2025-09-01', 'http://example.com/rxn11', 6),
(12, 'Neutralization', 'Acid-base reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.345, 0.978, 200.0, 400.0, 2.0, 15.0, 'Neutral pH monitoring', 'Neutralization', 'Approved', '2025-09-01', 'http://example.com/rxn12', 4),
(13, 'Saponification', 'Soap formation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.456, 0.989, 250.0, 450.0, 5.0, 20.0, 'Base handling', 'Saponification', 'Approved', '2025-09-01', 'http://example.com/rxn13', 5),
(14, 'Desulfurization', 'Sulfur removal reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 3.567, 1.000, 300.0, 500.0, 1.0, 10.0, 'Sulfur hazard', 'Desulfurization', 'Approved', '2025-09-01', 'http://example.com/rxn14', 6),
(15, 'Amination', 'Amine formation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.678, 1.011, 200.0, 400.0, 2.0, 15.0, 'Ammonia safety', 'Amination', 'Approved', '2025-09-01', 'http://example.com/rxn15', 5),
(16, 'Halogenation', 'Halogen addition reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.789, 1.022, 250.0, 450.0, 5.0, 20.0, 'Halogen hazard', 'Halogenation', 'Approved', '2025-09-01', 'http://example.com/rxn16', 6),
(17, 'Nitration', 'Nitro group addition reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.890, 1.033, 300.0, 500.0, 1.0, 10.0, 'Explosive risk', 'Nitration', 'Approved', '2025-09-01', 'http://example.com/rxn17', 6),
(18, 'Sulfonation', 'Sulfonic acid formation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 3.901, 1.044, 200.0, 400.0, 2.0, 15.0, 'Corrosive materials', 'Sulfonation', 'Approved', '2025-09-01', 'http://example.com/rxn18', 5),
(19, 'Fermentation', 'Biochemical reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.012, 1.055, 250.0, 450.0, 5.0, 20.0, 'Biohazard safety', 'Fermentation', 'Approved', '2025-09-01', 'http://example.com/rxn19', 4),
(20, 'Photochemical', 'Light-driven reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.123, 1.066, 300.0, 500.0, 1.0, 10.0, 'Light exposure', 'Photochemical', 'Approved', '2025-09-01', 'http://example.com/rxn20', 5),
(21, 'Electrochemical', 'Electron-driven reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.234, 1.077, 200.0, 400.0, 2.0, 15.0, 'Electrical safety', 'Electrochemical', 'Approved', '2025-09-01', 'http://example.com/rxn21', 4),
(22, 'Reduction', 'Reduction reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 3.345, 1.088, 250.0, 450.0, 5.0, 20.0, 'Reducing agent safety', 'Reduction', 'Approved', '2025-09-01', 'http://example.com/rxn22', 5),
(23, 'Hydroformylation', 'Aldehyde formation reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.456, 1.099, 300.0, 500.0, 1.0, 10.0, 'CO hazard', 'Hydroformylation', 'Approved', '2025-09-01', 'http://example.com/rxn23', 6),
(24, 'Acylation', 'Acyl group addition reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 1.567, 1.110, 200.0, 400.0, 2.0, 15.0, 'Acid chloride safety', 'Acylation', 'Approved', '2025-09-01', 'http://example.com/rxn24', 5),
(25, 'Dehydration', 'Water removal reaction', 'Admin', '2025-09-01', NULL, NULL, 1, 2.678, 1.121, 250.0, 450.0, 5.0, 20.0, 'High temperature caution', 'Dehydration', 'Approved', '2025-09-01', 'http://example.com/rxn25', 6);

-- 12. Reactants (Core)
INSERT INTO Reactants (Name, MolecularFormula, MolecularWeight, CASNumber, Purity, Density, BoilingPoint, MeltingPoint, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsHazardous, StorageConditions, SupplierContact, SafetyDataSheetURL, ApprovalStatus, LastValidatedDate)
VALUES
('Ethylene', 'C2H4', 28.05, '74-85-1', 99.5, 0.001, 103.7, -169.2, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool, ventilated area', 'contact@chemcorp.com', 'http://example.com/sds1', 'Approved', '2025-09-01'),
('Propylene', 'C3H6', 42.08, '115-07-1', 99.0, 0.002, 47.6, -185.2, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'contact@petrochem.com', 'http://example.com/sds2', 'Approved', '2025-09-01'),
('Benzene', 'C6H6', 78.11, '71-43-2', 99.8, 0.879, 80.1, 5.5, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 'contact@chemsupply.com', 'http://example.com/sds3', 'Approved', '2025-09-01'),
('Toluene', 'C7H8', 92.14, '108-88-3', 99.7, 0.867, 110.6, -95.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@industchem.com', 'http://example.com/sds4', 'Approved', '2025-09-01'),
('Ethanol', 'C2H5OH', 46.07, '64-17-5', 99.9, 0.789, 78.4, -114.1, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'contact@synthochem.com', 'http://example.com/sds5', 'Approved', '2025-09-01'),
('Methanol', 'CH3OH', 32.04, '67-56-1', 99.8, 0.792, 64.7, -97.6, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@chemcorp.com', 'http://example.com/sds6', 'Approved', '2025-09-01'),
('Acetic Acid', 'C2H4O2', 60.05, '64-19-7', 99.5, 1.049, 118.1, 16.6, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in corrosion-resistant container', 'contact@petrochem.com', 'http://example.com/sds7', 'Approved', '2025-09-01'),
('Butane', 'C4H10', 58.12, '106-97-8', 99.0, 0.002, -0.5, -138.3, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'contact@chemsupply.com', 'http://example.com/sds8', 'Approved', '2025-09-01'),
('Propane', 'C3H8', 44.10, '74-98-6', 99.5, 0.002, -42.1, -187.7, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@industchem.com', 'http://example.com/sds9', 'Approved', '2025-09-01'),
('Styrene', 'C8H8', 104.15, '100-42-5', 99.8, 0.906, 145.2, -30.6, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'contact@synthochem.com', 'http://example.com/sds10', 'Approved', '2025-09-01'),
('Ethylbenzene', 'C8H10', 106.17, '100-41-4', 99.7, 0.867, 136.2, -95.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 'contact@chemcorp.com', 'http://example.com/sds11', 'Approved', '2025-09-01'),
('Xylene', 'C8H10', 106.17, '1330-20-7', 99.6, 0.864, 138.4, -47.9, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@petrochem.com', 'http://example.com/sds12', 'Approved', '2025-09-01'),
('Methane', 'CH4', 16.04, '74-82-8', 99.9, 0.001, -161.5, -182.5, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'contact@chemsupply.com', 'http://example.com/sds13', 'Approved', '2025-09-01'),
('Ethane', 'C2H6', 30.07, '74-84-0', 99.5, 0.001, -88.6, -183.3, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@industchem.com', 'http://example.com/sds14', 'Approved', '2025-09-01'),
('Butene', 'C4H8', 56.11, '106-98-9', 99.0, 0.002, -6.3, -185.3, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'contact@synthochem.com', 'http://example.com/sds15', 'Approved', '2025-09-01'),
('Acetylene', 'C2H2', 26.04, '74-86-2', 99.5, 0.001, -84.0, -80.8, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in stable conditions', 'contact@chemcorp.com', 'http://example.com/sds16', 'Approved', '2025-09-01'),
('Formaldehyde', 'CH2O', 30.03, '50-00-0', 99.8, 1.083, -19.5, -92.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@petrochem.com', 'http://example.com/sds17', 'Approved', '2025-09-01'),
('Acetone', 'C3H6O', 58.08, '67-64-1', 99.9, 0.785, 56.0, -94.7, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'contact@chemsupply.com', 'http://example.com/sds18', 'Approved', '2025-09-01'),
('Vinyl Chloride', 'C2H3Cl', 62.50, '75-01-4', 99.5, 0.911, -13.4, -153.8, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'contact@industchem.com', 'http://example.com/sds19', 'Approved', '2025-09-01'),
('Ethylene Oxide', 'C2H4O', 44.05, '75-21-8', 99.7, 0.882, 10.7, -112.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@synthochem.com', 'http://example.com/sds20', 'Approved', '2025-09-01'),
('Propylene Oxide', 'C3H6O', 58.08, '75-56-9', 99.6, 0.830, 34.3, -112.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 'contact@chemcorp.com', 'http://example.com/sds21', 'Approved', '2025-09-01'),
('Butadiene', 'C4H6', 54.09, '106-99-0', 99.5, 0.621, -4.4, -108.9, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'contact@petrochem.com', 'http://example.com/sds22', 'Approved', '2025-09-01'),
('Isoprene', 'C5H8', 68.12, '78-79-5', 99.0, 0.681, 34.1, -145.9, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@chemsupply.com', 'http://example.com/sds23', 'Approved', '2025-09-01'),
('Chloroprene', 'C4H5Cl', 88.54, '126-99-8', 99.5, 0.959, 59.4, -130.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@industchem.com', 'http://example.com/sds24', 'Approved', '2025-09-01'),
('Acrylonitrile', 'C3H3N', 53.06, '107-13-1', 99.8, 0.806, 77.3, -83.5, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'contact@synthochem.com', 'http://example.com/sds25', 'Approved', '2025-09-01');

-- 13. Products (Core)
INSERT INTO Products (Name, MolecularFormula, MolecularWeight, CASNumber, Purity, Density, BoilingPoint, MeltingPoint, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsHazardous, StorageConditions, SupplierContact, SafetyDataSheetURL, ApprovalStatus, LastValidatedDate)
VALUES
('Polyethylene', 'C2H4', 28.05, '9002-88-4', 99.5, 0.950, NULL, 130.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@chemcorp.com', 'http://example.com/sds26', 'Approved', '2025-09-01'),
('Polypropylene', 'C3H6', 42.08, '9003-07-0', 99.0, 0.905, NULL, 160.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@petrochem.com', 'http://example.com/sds27', 'Approved', '2025-09-01'),
('Gasoline', 'C6-C12', 100.00, '8006-61-9', 99.8, 0.740, 40.0, NULL, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@chemsupply.com', 'http://example.com/sds28', 'Approved', '2025-09-01'),
('Diesel', 'C12-C20', 200.00, '68334-30-5', 99.7, 0.830, 180.0, NULL, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@industchem.com', 'http://example.com/sds29', 'Approved', '2025-09-01'),
('Ethyl Acetate', 'C4H8O2', 88.11, '141-78-6', 99.9, 0.902, 77.1, -83.6, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'contact@synthochem.com', 'http://example.com/sds30', 'Approved', '2025-09-01'),
('Methyl Acetate', 'C3H6O2', 74.08, '79-20-9', 99.8, 0.934, 57.1, -98.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@chemcorp.com', 'http://example.com/sds31', 'Approved', '2025-09-01'),
('Butanol', 'C4H10O', 74.12, '71-36-3', 99.5, 0.810, 117.7, -89.8, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@petrochem.com', 'http://example.com/sds32', 'Approved', '2025-09-01'),
('Propylene Glycol', 'C3H8O2', 76.09, '57-55-6', 99.0, 1.036, 188.2, -59.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@chemsupply.com', 'http://example.com/sds33', 'Approved', '2025-09-01'),
('Polystyrene', 'C8H8', 104.15, '9003-53-6', 99.5, 1.050, NULL, 240.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@industchem.com', 'http://example.com/sds34', 'Approved', '2025-09-01'),
('Ethylbenzene', 'C8H10', 106.17, '100-41-4', 99.7, 0.867, 136.2, -95.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@synthochem.com', 'http://example.com/sds35', 'Approved', '2025-09-01'),
('Xylene', 'C8H10', 106.17, '1330-20-7', 99.6, 0.864, 138.4, -47.9, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@chemcorp.com', 'http://example.com/sds36', 'Approved', '2025-09-01'),
('Methanol', 'CH3OH', 32.04, '67-56-1', 99.8, 0.792, 64.7, -97.6, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'contact@petrochem.com', 'http://example.com/sds37', 'Approved', '2025-09-01'),
('Ethanol', 'C2H5OH', 46.07, '64-17-5', 99.9, 0.789, 78.4, -114.1, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@chemsupply.com', 'http://example.com/sds38', 'Approved', '2025-09-01'),
('Acetone', 'C3H6O', 58.08, '67-64-1', 99.9, 0.785, 56.0, -94.7, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@industchem.com', 'http://example.com/sds39', 'Approved', '2025-09-01'),
('Vinyl Acetate', 'C4H6O2', 86.09, '108-05-4', 99.5, 0.934, 72.7, -93.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@synthochem.com', 'http://example.com/sds40', 'Approved', '2025-09-01'),
('Polyvinyl Chloride', 'C2H3Cl', 62.50, '9002-86-2', 99.5, 1.400, NULL, 80.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@chemcorp.com', 'http://example.com/sds41', 'Approved', '2025-09-01'),
('Ethylene Glycol', 'C2H6O2', 62.07, '107-21-1', 99.8, 1.113, 197.3, -12.9, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'contact@petrochem.com', 'http://example.com/sds42', 'Approved', '2025-09-01'),
('Propylene Oxide', 'C3H6O', 58.08, '75-56-9', 99.6, 0.830, 34.3, -112.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@chemsupply.com', 'http://example.com/sds43', 'Approved', '2025-09-01'),
('Butadiene Rubber', 'C4H6', 54.09, '9003-17-2', 99.0, 0.900, NULL, -80.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@industchem.com', 'http://example.com/sds44', 'Approved', '2025-09-01'),
('Isoprene Rubber', 'C5H8', 68.12, '9003-31-0', 99.5, 0.920, NULL, -70.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@synthochem.com', 'http://example.com/sds45', 'Approved', '2025-09-01'),
('Chloroprene Rubber', 'C4H5Cl', 88.54, '9002-98-6', 99.5, 1.230, NULL, -40.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@chemcorp.com', 'http://example.com/sds46', 'Approved', '2025-09-01'),
('Acrylonitrile Polymer', 'C3H3N', 53.06, '9003-56-9', 99.8, 1.150, NULL, 90.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@petrochem.com', 'http://example.com/sds47', 'Approved', '2025-09-01'),
('Kerosene', 'C10-C16', 150.00, '8008-20-6', 99.7, 0.800, 150.0, NULL, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'contact@chemsupply.com', 'http://example.com/sds48', 'Approved', '2025-09-01'),
('Lubricating Oil', 'C20-C40', 400.00, '8012-95-1', 99.5, 0.850, 300.0, NULL, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in cool area', 'contact@industchem.com', 'http://example.com/sds49', 'Approved', '2025-09-01'),
('Asphalt', 'C40+', 500.00, '8052-42-4', 99.0, 1.000, NULL, 100.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Store in dry area', 'contact@synthochem.com', 'http://example.com/sds50', 'Approved', '2025-09-01');

-- 14. Catalysts (Core)
INSERT INTO Catalysts (Name, Composition, SupplierID, CASNumber, SurfaceArea, ParticleSize, ActivityLevel, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsReusable, StorageConditions, CostPerUnit, SafetyDataSheetURL, ApprovalStatus, LastValidatedDate, CatalystType)
VALUES
('Zeolite Y', 'SiO2/Al2O3', 1, '1318-02-1', 600.0, 0.1, 95.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 100.0, 'http://example.com/sds51', 'Approved', '2025-09-01', 'Zeolite'),
('Platinum', 'Pt', 2, '7440-06-4', 200.0, 0.05, 98.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 5000.0, 'http://example.com/sds52', 'Approved', '2025-09-01', 'Metal'),
('Palladium', 'Pd', 3, '7440-05-3', 250.0, 0.04, 97.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 4500.0, 'http://example.com/sds53', 'Approved', '2025-09-01', 'Metal'),
('Nickel', 'Ni', 4, '7440-02-0', 150.0, 0.06, 90.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 200.0, 'http://example.com/sds54', 'Approved', '2025-09-01', 'Metal'),
('ZSM-5', 'SiO2/Al2O3', 5, '1318-02-1', 400.0, 0.1, 94.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 150.0, 'http://example.com/sds55', 'Approved', '2025-09-01', 'Zeolite'),
('Alumina', 'Al2O3', 6, '1344-28-1', 300.0, 0.2, 92.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 50.0, 'http://example.com/sds56', 'Approved', '2025-09-01', 'Oxide'),
('Silica', 'SiO2', 7, '7631-86-9', 500.0, 0.15, 90.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 40.0, 'http://example.com/sds57', 'Approved', '2025-09-01', 'Oxide'),
('Rhodium', 'Rh', 8, '7440-16-6', 220.0, 0.05, 98.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 6000.0, 'http://example.com/sds58', 'Approved', '2025-09-01', 'Metal'),
('Iron', 'Fe', 9, '7439-89-6', 100.0, 0.07, 88.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 30.0, 'http://example.com/sds59', 'Approved', '2025-09-01', 'Metal'),
('Cobalt', 'Co', 10, '7440-48-4', 120.0, 0.06, 89.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 200.0, 'http://example.com/sds60', 'Approved', '2025-09-01', 'Metal'),
('Molybdenum', 'Mo', 11, '7439-98-7', 130.0, 0.08, 87.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 250.0, 'http://example.com/sds61', 'Approved', '2025-09-01', 'Metal'),
('Titanium Oxide', 'TiO2', 12, '13463-67-7', 350.0, 0.2, 91.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 60.0, 'http://example.com/sds62', 'Approved', '2025-09-01', 'Oxide'),
('Zinc Oxide', 'ZnO', 13, '1314-13-2', 300.0, 0.15, 90.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 50.0, 'http://example.com/sds63', 'Approved', '2025-09-01', 'Oxide'),
('Chromium Oxide', 'Cr2O3', 14, '1308-38-9', 280.0, 0.2, 89.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 70.0, 'http://example.com/sds64', 'Approved', '2025-09-01', 'Oxide'),
('MCM-41', 'SiO2', 15, '1318-02-1', 800.0, 0.1, 95.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 200.0, 'http://example.com/sds65', 'Approved', '2025-09-01', 'Mesoporous'),
('SAPO-34', 'SiO2/Al2O3/PO4', 16, '1318-02-1', 600.0, 0.1, 94.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 180.0, 'http://example.com/sds66', 'Approved', '2025-09-01', 'Zeolite'),
('Beta Zeolite', 'SiO2/Al2O3', 17, '1318-02-1', 550.0, 0.1, 93.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 170.0, 'http://example.com/sds67', 'Approved', '2025-09-01', 'Zeolite'),
('Raney Nickel', 'Ni/Al', 18, '7440-02-0', 100.0, 0.06, 88.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 250.0, 'http://example.com/sds68', 'Approved', '2025-09-01', 'Metal'),
('Copper', 'Cu', 19, '7440-50-8', 110.0, 0.07, 87.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 150.0, 'http://example.com/sds69', 'Approved', '2025-09-01', 'Metal'),
('Vanadium Oxide', 'V2O5', 20, '1314-62-1', 200.0, 0.2, 90.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 80.0, 'http://example.com/sds70', 'Approved', '2025-09-01', 'Oxide'),
('Palladium on Carbon', 'Pd/C', 21, '7440-05-3', 300.0, 0.05, 96.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 4000.0, 'http://example.com/sds71', 'Approved', '2025-09-01', 'Supported Metal'),
('Platinum on Alumina', 'Pt/Al2O3', 22, '7440-06-4', 250.0, 0.05, 97.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 4500.0, 'http://example.com/sds72', 'Approved', '2025-09-01', 'Supported Metal'),
('Nickel on Silica', 'Ni/SiO2', 23, '7440-02-0', 200.0, 0.06, 90.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 200.0, 'http://example.com/sds73', 'Approved', '2025-09-01', 'Supported Metal'),
('Cobalt on Alumina', 'Co/Al2O3', 24, '7440-48-4', 180.0, 0.07, 89.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 250.0, 'http://example.com/sds74', 'Approved', '2025-09-01', 'Supported Metal'),
('Molybdenum Sulfide', 'MoS2', 25, '1317-33-5', 150.0, 0.08, 88.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in dry area', 300.0, 'http://example.com/sds75', 'Approved', '2025-09-01', 'Sulfide');

-- 15. Experiments (Core)
INSERT INTO Experiments (ReactionID, Date, Temperature, Pressure, Concentration, Yield, ConversionRate, LocationID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, DurationMinutes, EquipmentCondition, SafetyCompliance, ExperimentStatus, Notes, ApprovalStatus)
VALUES
(1, '2025-09-01', 400.0, 5.0, 0.1, 85.0, 90.0, 1, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Successful experiment', 'Approved'),
(2, '2025-09-02', 350.0, 10.0, 0.2, 80.0, 85.0, 2, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Stable conditions', 'Approved'),
(3, '2025-09-03', 300.0, 15.0, 0.15, 90.0, 95.0, 3, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'High yield', 'Approved'),
(4, '2025-09-04', 450.0, 20.0, 0.1, 75.0, 80.0, 4, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Reforming success', 'Approved'),
(5, '2025-09-05', 400.0, 5.0, 0.2, 82.0, 88.0, 5, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Oxidation stable', 'Approved'),
(6, '2025-09-06', 350.0, 10.0, 0.15, 78.0, 85.0, 6, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Isomerization success', 'Approved'),
(7, '2025-09-07', 300.0, 15.0, 0.1, 80.0, 90.0, 7, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Alkylation stable', 'Approved'),
(8, '2025-09-08', 400.0, 5.0, 0.2, 85.0, 90.0, 8, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Dehydrogenation success', 'Approved'),
(9, '2025-09-09', 350.0, 10.0, 0.15, 82.0, 88.0, 9, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Esterification stable', 'Approved'),
(10, '2025-09-10', 300.0, 15.0, 0.1, 78.0, 85.0, 10, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Hydrolysis success', 'Approved'),
(11, '2025-09-11', 400.0, 5.0, 0.2, 80.0, 90.0, 11, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Condensation stable', 'Approved'),
(12, '2025-09-12', 350.0, 10.0, 0.15, 85.0, 90.0, 12, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Neutralization success', 'Approved'),
(13, '2025-09-13', 300.0, 15.0, 0.1, 82.0, 88.0, 13, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Saponification stable', 'Approved'),
(14, '2025-09-14', 400.0, 5.0, 0.2, 78.0, 85.0, 14, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Desulfurization success', 'Approved'),
(15, '2025-09-15', 350.0, 10.0, 0.15, 80.0, 90.0, 15, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Amination stable', 'Approved'),
(16, '2025-09-16', 300.0, 15.0, 0.1, 85.0, 90.0, 16, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Halogenation success', 'Approved'),
(17, '2025-09-17', 400.0, 5.0, 0.2, 82.0, 88.0, 17, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Nitration stable', 'Approved'),
(18, '2025-09-18', 350.0, 10.0, 0.15, 78.0, 85.0, 18, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Sulfonation success', 'Approved'),
(19, '2025-09-19', 300.0, 15.0, 0.1, 80.0, 90.0, 19, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Fermentation stable', 'Approved'),
(20, '2025-09-20', 400.0, 5.0, 0.2, 85.0, 90.0, 20, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Photochemical success', 'Approved'),
(21, '2025-09-21', 350.0, 10.0, 0.15, 82.0, 88.0, 21, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Electrochemical stable', 'Approved'),
(22, '2025-09-22', 300.0, 15.0, 0.1, 78.0, 85.0, 22, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Reduction success', 'Approved'),
(23, '2025-09-23', 400.0, 5.0, 0.2, 80.0, 90.0, 23, 'Admin', '2025-09-01', NULL, NULL, 90, 'Good', 1, 'Completed', 'Hydroformylation stable', 'Approved'),
(24, '2025-09-24', 350.0, 10.0, 0.15, 85.0, 90.0, 24, 'Admin', '2025-09-01', NULL, NULL, 120, 'Good', 1, 'Completed', 'Acylation success', 'Approved'),
(25, '2025-09-25', 300.0, 15.0, 0.1, 82.0, 88.0, 25, 'Admin', '2025-09-01', NULL, NULL, 60, 'Good', 1, 'Completed', 'Dehydration stable', 'Approved');

USE ChemKineticsDB;
GO

-- 16. ExperimentConditions (Core, continued)
INSERT INTO ExperimentConditions (ExperimentID, ParameterName, Value, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsCritical, Tolerance, MeasurementMethod, CalibrationStatus, ApprovalStatus, LastValidatedDate, ParameterCategory, DocumentationURL, Notes)
VALUES
(2, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond4', 'Critical parameter'),
(3, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond5', 'Critical parameter'),
(3, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond6', 'Critical parameter'),
(4, 'Temperature', 450.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond7', 'Critical parameter'),
(4, 'Pressure', 20.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond8', 'Critical parameter'),
(5, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond9', 'Critical parameter'),
(5, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond10', 'Critical parameter'),
(6, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond11', 'Critical parameter'),
(6, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond12', 'Critical parameter'),
(7, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond13', 'Critical parameter'),
(7, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond14', 'Critical parameter'),
(8, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond15', 'Critical parameter'),
(8, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond16', 'Critical parameter'),
(9, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond17', 'Critical parameter'),
(9, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond18', 'Critical parameter'),
(10, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond19', 'Critical parameter'),
(10, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond20', 'Critical parameter'),
(11, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond21', 'Critical parameter'),
(11, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond22', 'Critical parameter'),
(12, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond23', 'Critical parameter'),
(12, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond24', 'Critical parameter'),
(13, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond25', 'Critical parameter'),
(13, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'http://example.com/cond26', 'Critical parameter');

-- 17. Equipment (Core)
INSERT INTO Equipment (Name, Type, Manufacturer, Model, LocationID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Status, LastMaintenanceDate, CalibrationFrequencyMonths, Capacity, OperationalRangeMin, OperationalRangeMax, SafetyRating, ApprovalStatus, LastValidatedDate, Notes)
VALUES
('Reactor A', 'Batch Reactor', 'ChemTech', 'BR-100', 1, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 1000.0, 200.0, 500.0, 5, 'Approved', '2025-09-01', 'Main reactor'),
('Reactor B', 'Continuous Reactor', 'PetroEquip', 'CR-200', 2, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 2000.0, 300.0, 600.0, 4, 'Approved', '2025-09-01', 'High-capacity reactor'),
('Spectrometer X', 'Spectrometer', 'Analytix', 'SP-300', 3, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Chromatograph Y', 'Gas Chromatograph', 'ChemSys', 'GC-400', 4, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Pump Z', 'Centrifugal Pump', 'FlowTech', 'CP-500', 5, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 500.0, NULL, NULL, 4, 'Approved', '2025-09-01', 'Fluid transfer'),
('Heater H1', 'Heater', 'ThermCo', 'TH-600', 6, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, NULL, 100.0, 700.0, 5, 'Approved', '2025-09-01', 'Temperature control'),
('Cooler C1', 'Cooler', 'CoolTech', 'CL-700', 7, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, NULL, -50.0, 100.0, 5, 'Approved', '2025-09-01', 'Temperature control'),
('Reactor C', 'Batch Reactor', 'ChemTech', 'BR-101', 8, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 1000.0, 200.0, 500.0, 5, 'Approved', '2025-09-01', 'Secondary reactor'),
('Reactor D', 'Continuous Reactor', 'PetroEquip', 'CR-201', 9, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 2000.0, 300.0, 600.0, 4, 'Approved', '2025-09-01', 'High-capacity reactor'),
('Spectrometer Z', 'Spectrometer', 'Analytix', 'SP-301', 10, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Chromatograph W', 'Gas Chromatograph', 'ChemSys', 'GC-401', 11, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Pump X', 'Centrifugal Pump', 'FlowTech', 'CP-501', 12, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 500.0, NULL, NULL, 4, 'Approved', '2025-09-01', 'Fluid transfer'),
('Heater H2', 'Heater', 'ThermCo', 'TH-601', 13, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, NULL, 100.0, 700.0, 5, 'Approved', '2025-09-01', 'Temperature control'),
('Cooler C2', 'Cooler', 'CoolTech', 'CL-701', 14, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, NULL, -50.0, 100.0, 5, 'Approved', '2025-09-01', 'Temperature control'),
('Reactor E', 'Batch Reactor', 'ChemTech', 'BR-102', 15, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 1000.0, 200.0, 500.0, 5, 'Approved', '2025-09-01', 'Main reactor'),
('Reactor F', 'Continuous Reactor', 'PetroEquip', 'CR-202', 16, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 2000.0, 300.0, 600.0, 4, 'Approved', '2025-09-01', 'High-capacity reactor'),
('Spectrometer V', 'Spectrometer', 'Analytix', 'SP-302', 17, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Chromatograph U', 'Gas Chromatograph', 'ChemSys', 'GC-402', 18, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Pump Y', 'Centrifugal Pump', 'FlowTech', 'CP-502', 19, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 500.0, NULL, NULL, 4, 'Approved', '2025-09-01', 'Fluid transfer'),
('Heater H3', 'Heater', 'ThermCo', 'TH-602', 20, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, NULL, 100.0, 700.0, 5, 'Approved', '2025-09-01', 'Temperature control'),
('Cooler C3', 'Cooler', 'CoolTech', 'CL-702', 21, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, NULL, -50.0, 100.0, 5, 'Approved', '2025-09-01', 'Temperature control'),
('Reactor G', 'Batch Reactor', 'ChemTech', 'BR-103', 22, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 1000.0, 200.0, 500.0, 5, 'Approved', '2025-09-01', 'Main reactor'),
('Reactor H', 'Continuous Reactor', 'PetroEquip', 'CR-203', 23, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 6, 2000.0, 300.0, 600.0, 4, 'Approved', '2025-09-01', 'High-capacity reactor'),
('Spectrometer T', 'Spectrometer', 'Analytix', 'SP-303', 24, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment'),
('Chromatograph S', 'Gas Chromatograph', 'ChemSys', 'GC-403', 25, 'Admin', '2025-09-01', NULL, NULL, 'Operational', '2025-08-01', 3, NULL, NULL, NULL, 5, 'Approved', '2025-09-01', 'Analytical equipment');

-- 18. Byproducts (Core)
INSERT INTO Byproducts (Name, MolecularFormula, MolecularWeight, CASNumber, ReactionID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsHazardous, DisposalInstructions, ApprovalStatus, LastValidatedDate, SafetyDataSheetURL, Notes)
VALUES
('Carbon Dioxide', 'CO2', 44.01, '124-38-9', 1, 'Admin', '2025-09-01', NULL, NULL, 0, 'Vent to atmosphere', 'Approved', '2025-09-01', 'http://example.com/sds76', 'Common byproduct'),
('Water', 'H2O', 18.02, '7732-18-5', 2, 'Admin', '2025-09-01', NULL, NULL, 0, 'Safe disposal', 'Approved', '2025-09-01', 'http://example.com/sds77', 'Non-hazardous'),
('Carbon Monoxide', 'CO', 28.01, '630-08-0', 3, 'Admin', '2025-09-01', NULL, NULL, 1, 'Vent with caution', 'Approved', '2025-09-01', 'http://example.com/sds78', 'Toxic gas'),
('Sulfur Dioxide', 'SO2', 64.06, '7446-09-5', 4, 'Admin', '2025-09-01', NULL, NULL, 1, 'Neutralize before disposal', 'Approved', '2025-09-01', 'http://example.com/sds79', 'Corrosive gas'),
('Hydrogen Sulfide', 'H2S', 34.08, '7783-06-4', 5, 'Admin', '2025-09-01', NULL, NULL, 1, 'Scrub before disposal', 'Approved', '2025-09-01', 'http://example.com/sds80', 'Highly toxic'),
('Ammonia', 'NH3', 17.03, '7664-41-7', 6, 'Admin', '2025-09-01', NULL, NULL, 1, 'Neutralize before disposal', 'Approved', '2025-09-01', 'http://example.com/sds81', 'Corrosive gas'),
('Methane', 'CH4', 16.04, '74-82-8', 7, 'Admin', '2025-09-01', NULL, NULL, 1, 'Vent with caution', 'Approved', '2025-09-01', 'http://example.com/sds82', 'Flammable gas'),
('Ethane', 'C2H6', 30.07, '74-84-0', 8, 'Admin', '2025-09-01', NULL, NULL, 1, 'Vent with caution', 'Approved', '2025-09-01', 'http://example.com/sds83', 'Flammable gas'),
('Propane', 'C3H8', 44.10, '74-98-6', 9, 'Admin', '2025-09-01', NULL, NULL, 1, 'Vent with caution', 'Approved', '2025-09-01', 'http://example.com/sds84', 'Flammable gas'),
('Butane', 'C4H10', 58.12, '106-97-8', 10, 'Admin', '2025-09-01', NULL, NULL, 1, 'Vent with caution', 'Approved', '2025-09-01', 'http://example.com/sds85', 'Flammable gas'),
('Nitrogen Oxides', 'NOx', 46.01, '10102-43-9', 11, 'Admin', '2025-09-01', NULL, NULL, 1, 'Scrub before disposal', 'Approved', '2025-09-01', 'http://example.com/sds86', 'Toxic gas'),
('Sulfuric Acid', 'H2SO4', 98.08, '7664-93-9', 12, 'Admin', '2025-09-01', NULL, NULL, 1, 'Neutralize before disposal', 'Approved', '2025-09-01', 'http://example.com/sds87', 'Corrosive liquid'),
('Hydrochloric Acid', 'HCl', 36.46, '7647-01-0', 13, 'Admin', '2025-09-01', NULL, NULL, 1, 'Neutralize before disposal', 'Approved', '2025-09-01', 'http://example.com/sds88', 'Corrosive liquid'),
('Sodium Chloride', 'NaCl', 58.44, '7647-14-5', 14, 'Admin', '2025-09-01', NULL, NULL, 0, 'Safe disposal', 'Approved', '2025-09-01', 'http://example.com/sds89', 'Non-hazardous'),
('Calcium Carbonate', 'CaCO3', 100.09, '471-34-1', 15, 'Admin', '2025-09-01', NULL, NULL, 0, 'Safe disposal', 'Approved', '2025-09-01', 'http://example.com/sds90', 'Non-hazardous'),
('Ethanol', 'C2H5OH', 46.07, '64-17-5', 16, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'Approved', '2025-09-01', 'http://example.com/sds91', 'Flammable liquid'),
('Methanol', 'CH3OH', 32.04, '67-56-1', 17, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'Approved', '2025-09-01', 'http://example.com/sds92', 'Flammable liquid'),
('Acetic Acid', 'C2H4O2', 60.05, '64-19-7', 18, 'Admin', '2025-09-01', NULL, NULL, 1, 'Neutralize before disposal', 'Approved', '2025-09-01', 'http://example.com/sds93', 'Corrosive liquid'),
('Formaldehyde', 'CH2O', 30.03, '50-00-0', 19, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'Approved', '2025-09-01', 'http://example.com/sds94', 'Toxic liquid'),
('Acetone', 'C3H6O', 58.08, '67-64-1', 20, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store away from heat', 'Approved', '2025-09-01', 'http://example.com/sds95', 'Flammable liquid'),
('Benzene', 'C6H6', 78.11, '71-43-2', 21, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in sealed container', 'Approved', '2025-09-01', 'http://example.com/sds96', 'Toxic liquid'),
('Toluene', 'C7H8', 92.14, '108-88-3', 22, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in cool area', 'Approved', '2025-09-01', 'http://example.com/sds97', 'Flammable liquid'),
('Xylene', 'C8H10', 106.17, '1330-20-7', 23, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store in ventilated area', 'Approved', '2025-09-01', 'http://example.com/sds98', 'Flammable liquid'),
('Ethylene', 'C2H4', 28.05, '74-85-1', 24, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'Approved', '2025-09-01', 'http://example.com/sds99', 'Flammable gas'),
('Propylene', 'C3H6', 42.08, '115-07-1', 25, 'Admin', '2025-09-01', NULL, NULL, 1, 'Store under pressure', 'Approved', '2025-09-01', 'http://example.com/sds100', 'Flammable gas');

-- 19. ReactionMechanisms (Core)
INSERT INTO ReactionMechanisms (ReactionID, MechanismDescription, StepCount, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsValidated, ValidationDate, DocumentationURL, Notes)
VALUES
(1, 'Radical chain mechanism for catalytic cracking', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech1', 'Well-characterized'),
(2, 'Cationic polymerization mechanism', 4, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech2', 'Stable mechanism'),
(3, 'Hydrogen addition via metal catalyst', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech3', 'High efficiency'),
(4, 'Catalytic reforming via dehydrogenation', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech4', 'Optimized process'),
(5, 'Oxidation via radical intermediates', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech5', 'Controlled reaction'),
(6, 'Isomerization via carbocation rearrangement', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech6', 'Stable mechanism'),
(7, 'Alkylation via electrophilic addition', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech7', 'High selectivity'),
(8, 'Dehydrogenation via metal catalyst', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech8', 'Efficient process'),
(9, 'Esterification via nucleophilic substitution', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech9', 'Well-characterized'),
(10, 'Hydrolysis via nucleophilic attack', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech10', 'Stable mechanism'),
(11, 'Condensation via dehydration', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech11', 'Controlled reaction'),
(12, 'Neutralization via proton transfer', 1, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech12', 'Simple mechanism'),
(13, 'Saponification via nucleophilic attack', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech13', 'Stable mechanism'),
(14, 'Desulfurization via hydrogenolysis', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech14', 'Efficient process'),
(15, 'Amination via nucleophilic substitution', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech15', 'High yield'),
(16, 'Halogenation via electrophilic addition', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech16', 'Controlled reaction'),
(17, 'Nitration via electrophilic substitution', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech17', 'High selectivity'),
(18, 'Sulfonation via electrophilic substitution', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech18', 'Stable mechanism'),
(19, 'Fermentation via enzymatic catalysis', 5, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech19', 'Complex mechanism'),
(20, 'Photochemical reaction via excitation', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech20', 'Light-driven'),
(21, 'Electrochemical reaction via electron transfer', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech21', 'Controlled reaction'),
(22, 'Reduction via electron addition', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech22', 'High efficiency'),
(23, 'Hydroformylation via metal catalysis', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech23', 'Stable mechanism'),
(24, 'Acylation via electrophilic substitution', 3, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech24', 'Controlled reaction'),
(25, 'Dehydration via elimination', 2, 'Admin', '2025-09-01', NULL, NULL, 1, '2025-09-01', 'http://example.com/mech25', 'High yield');

-- 20. ReactionKinetics (Core)
INSERT INTO ReactionKinetics (ReactionID, RateLaw, RateConstant, ActivationEnergy, PreExponentialFactor, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Temperature, Pressure, ValidationStatus, ApprovalStatus, LastValidatedDate, Notes)
VALUES
(1, 'k[A]^2', 0.567, 50.0, 1.0E8, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Second-order kinetics'),
(2, 'k[A][B]', 0.678, 45.0, 2.0E8, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'Bimolecular reaction'),
(3, 'k[A]', 0.789, 40.0, 3.0E8, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(4, 'k[A]^2', 0.890, 55.0, 4.0E8, 'Admin', '2025-09-01', NULL, NULL, 450.0, 20.0, 'Validated', 'Approved', '2025-09-01', 'High activation energy'),
(5, 'k[A][B]', 0.901, 50.0, 5.0E8, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Stable kinetics'),
(6, 'k[A]', 0.912, 45.0, 6.0E8, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(7, 'k[A][B]', 0.923, 40.0, 7.0E8, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'Bimolecular reaction'),
(8, 'k[A]^2', 0.934, 50.0, 8.0E8, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Second-order kinetics'),
(9, 'k[A][B]', 0.945, 45.0, 9.0E8, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'Stable kinetics'),
(10, 'k[A]', 0.956, 40.0, 1.0E9, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(11, 'k[A][B]', 0.967, 50.0, 1.1E9, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Bimolecular reaction'),
(12, 'k[A]', 0.978, 45.0, 1.2E9, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(13, 'k[A][B]', 0.989, 40.0, 1.3E9, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'Stable kinetics'),
(14, 'k[A]^2', 1.000, 50.0, 1.4E9, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Second-order kinetics'),
(15, 'k[A][B]', 1.011, 45.0, 1.5E9, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'Bimolecular reaction'),
(16, 'k[A]', 1.022, 40.0, 1.6E9, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(17, 'k[A][B]', 1.033, 50.0, 1.7E9, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Stable kinetics'),
(18, 'k[A]^2', 1.044, 45.0, 1.8E9, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'Second-order kinetics'),
(19, 'k[A]', 1.055, 40.0, 1.9E9, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(20, 'k[A][B]', 1.066, 50.0, 2.0E9, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Bimolecular reaction'),
(21, 'k[A]', 1.077, 45.0, 2.1E9, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics'),
(22, 'k[A][B]', 1.088, 40.0, 2.2E9, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'Stable kinetics'),
(23, 'k[A]^2', 1.099, 50.0, 2.3E9, 'Admin', '2025-09-01', NULL, NULL, 400.0, 5.0, 'Validated', 'Approved', '2025-09-01', 'Second-order kinetics'),
(24, 'k[A][B]', 1.110, 45.0, 2.4E9, 'Admin', '2025-09-01', NULL, NULL, 350.0, 10.0, 'Validated', 'Approved', '2025-09-01', 'Bimolecular reaction'),
(25, 'k[A]', 1.121, 40.0, 2.5E9, 'Admin', '2025-09-01', NULL, NULL, 300.0, 15.0, 'Validated', 'Approved', '2025-09-01', 'First-order kinetics');

-- 21. SafetyIncidents (Core)
INSERT INTO SafetyIncidents (ExperimentID, IncidentDate, Description, Severity, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, CorrectiveAction, ApprovalStatus, LastValidatedDate, Notes)
VALUES
(1, '2025-09-01', 'Minor pressure spike', 2, 'Admin', '2025-09-01', NULL, NULL, 'Adjusted pressure regulator', 'Approved', '2025-09-01', 'Resolved'),
(2, '2025-09-02', 'Temperature overshoot', 3, 'Admin', '2025-09-01', NULL, NULL, 'Recalibrated heater', 'Approved', '2025-09-01', 'No damage'),
(3, '2025-09-03', 'Small leak detected', 2, 'Admin', '2025-09-01', NULL, NULL, 'Sealed connection', 'Approved', '2025-09-01', 'Resolved'),
(4, '2025-09-04', 'Equipment malfunction', 3, 'Admin', '2025-09-01', NULL, NULL, 'Replaced faulty valve', 'Approved', '2025-09-01', 'No injuries'),
(5, '2025-09-05', 'Chemical spill', 4, 'Admin', '2025-09-01', NULL, NULL, 'Cleaned and neutralized', 'Approved', '2025-09-01', 'Contained'),
(6, '2025-09-06', 'Minor explosion', 4, 'Admin', '2025-09-01', NULL, NULL, 'Revised safety protocols', 'Approved', '2025-09-01', 'No injuries'),
(7, '2025-09-07', 'Pressure drop', 2, 'Admin', '2025-09-01', NULL, NULL, 'Checked pump', 'Approved', '2025-09-01', 'Resolved'),
(8, '2025-09-08', 'Temperature fluctuation', 3, 'Admin', '2025-09-01', NULL, NULL, 'Recalibrated controls', 'Approved', '2025-09-01', 'Stable now'),
(9, '2025-09-09', 'Gas leak', 3, 'Admin', '2025-09-01', NULL, NULL, 'Repaired pipeline', 'Approved', '2025-09-01', 'Contained'),
(10, '2025-09-10', 'Equipment failure', 3, 'Admin', '2025-09-01', NULL, NULL, 'Replaced component', 'Approved', '2025-09-01', 'Operational'),
(11, '2025-09-11', 'Overheating', 3, 'Admin', '2025-09-01', NULL, NULL, 'Adjusted cooling system', 'Approved', '2025-09-01', 'Resolved'),
(12, '2025-09-12', 'Minor fire', 4, 'Admin', '2025-09-01', NULL, NULL, 'Extinguished and reviewed', 'Approved', '2025-09-01', 'No injuries'),
(13, '2025-09-13', 'Pressure surge', 2, 'Admin', '2025-09-01', NULL, NULL, 'Adjusted regulator', 'Approved', '2025-09-01', 'Stable'),
(14, '2025-09-14', 'Chemical exposure', 4, 'Admin', '2025-09-01', NULL, NULL, 'Improved ventilation', 'Approved', '2025-09-01', 'Contained'),
(15, '2025-09-15', 'Equipment jam', 2, 'Admin', '2025-09-01', NULL, NULL, 'Cleared obstruction', 'Approved', '2025-09-01', 'Resolved'),
(16, '2025-09-16', 'Gas release', 3, 'Admin', '2025-09-01', NULL, NULL, 'Sealed valve', 'Approved', '2025-09-01', 'No injuries'),
(17, '2025-09-17', 'Temperature spike', 3, 'Admin', '2025-09-01', NULL, NULL, 'Recalibrated heater', 'Approved', '2025-09-01', 'Stable'),
(18, '2025-09-18', 'Minor spill', 2, 'Admin', '2025-09-01', NULL, NULL, 'Cleaned and neutralized', 'Approved', '2025-09-01', 'Contained'),
(19, '2025-09-19', 'Equipment malfunction', 3, 'Admin', '2025-09-01', NULL, NULL, 'Repaired component', 'Approved', '2025-09-01', 'Operational'),
(20, '2025-09-20', 'Pressure drop', 2, 'Admin', '2025-09-01', NULL, NULL, 'Checked pump', 'Approved', '2025-09-01', 'Resolved'),
(21, '2025-09-21', 'Temperature overshoot', 3, 'Admin', '2025-09-01', NULL, NULL, 'Recalibrated controls', 'Approved', '2025-09-01', 'Stable'),
(22, '2025-09-22', 'Small leak', 2, 'Admin', '2025-09-01', NULL, NULL, 'Sealed connection', 'Approved', '2025-09-01', 'Resolved'),
(23, '2025-09-23', 'Chemical spill', 4, 'Admin', '2025-09-01', NULL, NULL, 'Cleaned and neutralized', 'Approved', '2025-09-01', 'Contained'),
(24, '2025-09-24', 'Equipment failure', 3, 'Admin', '2025-09-01', NULL, NULL, 'Replaced component', 'Approved', '2025-09-01', 'Operational'),
(25, '2025-09-25', 'Minor explosion', 4, 'Admin', '2025-09-01', NULL, NULL, 'Revised safety protocols', 'Approved', '2025-09-01', 'No injuries');

-- 22. AnalyticalMethods (Core)
INSERT INTO AnalyticalMethods (Name, Description, EquipmentID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, DetectionLimit, Accuracy, Precision, ValidationStatus, ApprovalStatus, LastValidatedDate, Notes)
VALUES
('GC-MS', 'Gas Chromatography-Mass Spectrometry', 3, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.5, 99.0, 'Validated', 'Approved', '2025-09-01', 'High sensitivity'),
('HPLC', 'High-Performance Liquid Chromatography', 4, 'Admin', '2025-09-01', NULL, NULL, 0.002, 99.0, 98.5, 'Validated', 'Approved', '2025-09-01', 'High resolution'),
('FTIR', 'Fourier Transform Infrared Spectroscopy', 3, 'Admin', '2025-09-01', NULL, NULL, 0.005, 98.5, 98.0, 'Validated', 'Approved', '2025-09-01', 'Functional group analysis'),
('NMR', 'Nuclear Magnetic Resonance', 10, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.8, 99.5, 'Validated', 'Approved', '2025-09-01', 'Structural analysis'),
('UV-Vis', 'Ultraviolet-Visible Spectroscopy', 17, 'Admin', '2025-09-01', NULL, NULL, 0.003, 98.0, 97.5, 'Validated', 'Approved', '2025-09-01', 'Concentration measurement'),
('ICP-MS', 'Inductively Coupled Plasma-Mass Spectrometry', 24, 'Admin', '2025-09-01', NULL, NULL, 0.0001, 99.9, 99.8, 'Validated', 'Approved', '2025-09-01', 'Trace element analysis'),
('GC-FID', 'Gas Chromatography-Flame Ionization Detection', 4, 'Admin', '2025-09-01', NULL, NULL, 0.002, 99.0, 98.5, 'Validated', 'Approved', '2025-09-01', 'Hydrocarbon analysis'),
('TGA', 'Thermogravimetric Analysis', 11, 'Admin', '2025-09-01', NULL, NULL, 0.01, 98.0, 97.0, 'Validated', 'Approved', '2025-09-01', 'Thermal stability'),
('DSC', 'Differential Scanning Calorimetry', 18, 'Admin', '2025-09-01', NULL, NULL, 0.01, 98.5, 97.5, 'Validated', 'Approved', '2025-09-01', 'Thermal properties'),
('XRF', 'X-Ray Fluorescence', 25, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.0, 98.0, 'Validated', 'Approved', '2025-09-01', 'Elemental analysis'),
('GC-TCD', 'Gas Chromatography-Thermal Conductivity Detection', 4, 'Admin', '2025-09-01', NULL, NULL, 0.005, 98.0, 97.0, 'Validated', 'Approved', '2025-09-01', 'Gas analysis'),
('IR Spectroscopy', 'Infrared Spectroscopy', 3, 'Admin', '2025-09-01', NULL, NULL, 0.005, 98.5, 98.0, 'Validated', 'Approved', '2025-09-01', 'Functional group analysis'),
('Mass Spectrometry', 'Mass Spectrometry', 10, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.5, 99.0, 'Validated', 'Approved', '2025-09-01', 'Molecular weight'),
('Raman Spectroscopy', 'Raman Spectroscopy', 17, 'Admin', '2025-09-01', NULL, NULL, 0.003, 98.0, 97.5, 'Validated', 'Approved', '2025-09-01', 'Molecular structure'),
('ICP-OES', 'Inductively Coupled Plasma-Optical Emission Spectroscopy', 24, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.0, 98.5, 'Validated', 'Approved', '2025-09-01', 'Elemental analysis'),
('GC-ECD', 'Gas Chromatography-Electron Capture Detection', 4, 'Admin', '2025-09-01', NULL, NULL, 0.0001, 99.5, 99.0, 'Validated', 'Approved', '2025-09-01', 'Halogenated compounds'),
('XPS', 'X-Ray Photoelectron Spectroscopy', 25, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.0, 98.0, 'Validated', 'Approved', '2025-09-01', 'Surface analysis'),
('SEM', 'Scanning Electron Microscopy', 11, 'Admin', '2025-09-01', NULL, NULL, 0.01, 98.0, 97.0, 'Validated', 'Approved', '2025-09-01', 'Surface morphology'),
('TEM', 'Transmission Electron Microscopy', 18, 'Admin', '2025-09-01', NULL, NULL, 0.01, 98.5, 97.5, 'Validated', 'Approved', '2025-09-01', 'Nanostructure analysis'),
('XRD', 'X-Ray Diffraction', 25, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.0, 98.0, 'Validated', 'Approved', '2025-09-01', 'Crystalline structure'),
('BET', 'Brunauer-Emmett-Teller Surface Area Analysis', 3, 'Admin', '2025-09-01', NULL, NULL, 0.01, 98.5, 97.5, 'Validated', 'Approved', '2025-09-01', 'Surface area measurement'),
('FT-NMR', 'Fourier Transform NMR', 10, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.8, 99.5, 'Validated', 'Approved', '2025-09-01', 'Structural analysis'),
('LC-MS', 'Liquid Chromatography-Mass Spectrometry', 4, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.5, 99.0, 'Validated', 'Approved', '2025-09-01', 'Complex mixture analysis'),
('AAS', 'Atomic Absorption Spectroscopy', 17, 'Admin', '2025-09-01', NULL, NULL, 0.001, 99.0, 98.5, 'Validated', 'Approved', '2025-09-01', 'Metal analysis'),
('TOC', 'Total Organic Carbon Analysis', 24, 'Admin', '2025-09-01', NULL, NULL, 0.001, 98.5, 98.0, 'Validated', 'Approved', '2025-09-01', 'Organic content');

-- 23. ReactionReactants (Bridge)
INSERT INTO ReactionReactants (ReactionID, ReactantID, StoichiometricCoefficient, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Role)
VALUES
(1, 1, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(1, 2, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(2, 3, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(2, 4, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(3, 5, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(3, 6, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(4, 7, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(4, 8, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(5, 9, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(5, 10, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(6, 11, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(6, 12, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(7, 13, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(7, 14, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(8, 15, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(8, 16, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(9, 17, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(9, 18, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(10, 19, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(10, 20, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(11, 21, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(11, 22, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(12, 23, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant'),
(12, 24, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Reactant'),
(13, 25, 1.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Reactant');

-- 24. ReactionProducts (Bridge)
INSERT INTO ReactionProducts (ReactionID, ProductID, StoichiometricCoefficient, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Yield)
VALUES
(1, 1, 1.0, 'Admin', '2025-09-01', NULL, NULL, 85.0),
(1, 2, 1.0, 'Admin', '2025-09-01', NULL, NULL, 80.0),
(2, 3, 1.0, 'Admin', '2025-09-01', NULL, NULL, 90.0),
(2, 4, 1.0, 'Admin', '2025-09-01', NULL, NULL, 75.0),
(3, 5, 1.0, 'Admin', '2025-09-01', NULL, NULL, 82.0),
(3, 6, 1.0, 'Admin', '2025-09-01', NULL, NULL, 78.0),
(4, 7, 1.0, 'Admin', '2025-09-01', NULL, NULL, 80.0),
(4, 8, 1.0, 'Admin', '2025-09-01', NULL, NULL, 85.0),
(5, 9, 1.0, 'Admin', '2025-09-01', NULL, NULL, 82.0),
(5, 10, 1.0, 'Admin', '2025-09-01', NULL, NULL, 78.0),
(6, 11, 1.0, 'Admin', '2025-09-01', NULL, NULL, 80.0),
(6, 12, 1.0, 'Admin', '2025-09-01', NULL, NULL, 85.0),
(7, 13, 1.0, 'Admin', '2025-09-01', NULL, NULL, 82.0),
(7, 14, 1.0, 'Admin', '2025-09-01', NULL, NULL, 78.0),
(8, 15, 1.0, 'Admin', '2025-09-01', NULL, NULL, 80.0),
(8, 16, 1.0, 'Admin', '2025-09-01', NULL, NULL, 85.0),
(9, 17, 1.0, 'Admin', '2025-09-01', NULL, NULL, 82.0),
(9, 18, 1.0, 'Admin', '2025-09-01', NULL, NULL, 78.0),
(10, 19, 1.0, 'Admin', '2025-09-01', NULL, NULL, 80.0),
(10, 20, 1.0, 'Admin', '2025-09-01', NULL, NULL, 85.0),
(11, 21, 1.0, 'Admin', '2025-09-01', NULL, NULL, 82.0),
(11, 22, 1.0, 'Admin', '2025-09-01', NULL, NULL, 78.0),
(12, 23, 1.0, 'Admin', '2025-09-01', NULL, NULL, 80.0),
(12, 24, 1.0, 'Admin', '2025-09-01', NULL, NULL, 85.0),
(13, 25, 1.0, 'Admin', '2025-09-01', NULL, NULL, 82.0);

-- 25. ReactionCatalysts (Bridge)
INSERT INTO ReactionCatalysts (ReactionID, CatalystID, AmountUsed, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, CatalystRole)
VALUES
(1, 1, 10.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(1, 2, 5.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(2, 3, 8.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(2, 4, 6.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(3, 5, 12.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(3, 6, 4.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(4, 7, 10.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(4, 8, 5.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(5, 9, 8.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(5, 10, 6.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(6, 11, 12.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(6, 12, 4.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(7, 13, 10.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(7, 14, 5.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(8, 15, 8.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(8, 16, 6.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(9, 17, 12.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(9, 18, 4.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(10, 19, 10.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(10, 20, 5.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(11, 21, 8.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(11, 22, 6.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(12, 23, 12.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst'),
(12, 24, 4.0, 'Admin', '2025-09-01', NULL, NULL, 'Secondary Catalyst'),
(13, 25, 10.0, 'Admin', '2025-09-01', NULL, NULL, 'Primary Catalyst');

-- 26. ExperimentResearchers (Bridge)
INSERT INTO ExperimentResearchers (ExperimentID, ResearcherID, Role, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)
VALUES
(1, 1, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(1, 2, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(2, 3, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(2, 4, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(3, 5, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(3, 6, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(4, 7, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(4, 8, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(5, 9, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(5, 10, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(6, 11, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(6, 12, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(7, 13, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(7, 14, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(8, 15, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(8, 16, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(9, 17, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(9, 18, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(10, 19, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(10, 20, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(11, 21, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(11, 22, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(12, 23, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL),
(12, 24, 'Assistant Researcher', 'Admin', '2025-09-01', NULL, NULL),
(13, 25, 'Lead Researcher', 'Admin', '2025-09-01', NULL, NULL);

-- 27. ExperimentEquipment (Bridge)
INSERT INTO ExperimentEquipment (ExperimentID, EquipmentID, UsageDetails, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)
VALUES
(1, 1, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL),
(1, 3, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(2, 2, 'Continuous reactor', 'Admin', '2025-09-01', NULL, NULL),
(2, 4, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(3, 5, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(3, 10, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(4, 6, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(4, 11, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(5, 7, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(5, 12, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(6, 8, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL),
(6, 13, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(7, 9, 'Continuous reactor', 'Admin', '2025-09-01', NULL, NULL),
(7, 14, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(8, 10, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(8, 15, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL),
(9, 11, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(9, 16, 'Continuous reactor', 'Admin', '2025-09-01', NULL, NULL),
(10, 12, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(10, 17, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(11, 13, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(11, 18, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(12, 14, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(12, 19, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(13, 15, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL);

USE ChemKineticsDB;
GO

-- 28. ExperimentByproducts (Bridge, continued)
INSERT INTO ExperimentByproducts (ExperimentID, ByproductID, Quantity, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)
VALUES
(10, 20, 5.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(11, 21, 8.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(11, 22, 6.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(12, 23, 12.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(12, 24, 4.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(13, 25, 10.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(13, 1, 5.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(14, 2, 8.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(14, 3, 6.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(15, 4, 12.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(15, 5, 4.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(16, 6, 10.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(16, 7, 5.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(17, 8, 8.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(17, 9, 6.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(18, 10, 12.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(18, 11, 4.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(19, 12, 10.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(19, 13, 5.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(20, 14, 8.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(20, 15, 6.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(21, 16, 12.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(21, 17, 4.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(22, 18, 10.0, 3, 'Admin', '2025-09-01', NULL, NULL),
(22, 19, 5.0, 3, 'Admin', '2025-09-01', NULL, NULL);

-- 29. ExperimentAnalyticalMethods (Bridge)
INSERT INTO ExperimentAnalyticalMethods (ExperimentID, MethodID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Notes)
VALUES
(1, 1, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(1, 2, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(2, 3, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(2, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(3, 5, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(3, 6, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(4, 7, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(4, 8, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(5, 9, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(5, 10, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(6, 11, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(6, 12, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(7, 13, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(7, 14, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(8, 15, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(8, 16, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(9, 17, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(9, 18, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(10, 19, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(10, 20, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(11, 21, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(11, 22, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(12, 23, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method'),
(12, 24, 'Admin', '2025-09-01', NULL, NULL, 'Secondary analysis method'),
(13, 25, 'Admin', '2025-09-01', NULL, NULL, 'Primary analysis method');

-- 30. ReactionSafetyHazards (Bridge)
INSERT INTO ReactionSafetyHazards (ReactionID, HazardID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Notes)
VALUES
(1, 1, 'Admin', '2025-09-01', NULL, NULL, 'High pressure risk'),
(1, 2, 'Admin', '2025-09-01', NULL, NULL, 'Flammable materials'),
(2, 3, 'Admin', '2025-09-01', NULL, NULL, 'Corrosive chemicals'),
(2, 4, 'Admin', '2025-09-01', NULL, NULL, 'Toxic byproducts'),
(3, 5, 'Admin', '2025-09-01', NULL, NULL, 'High temperature risk'),
(3, 6, 'Admin', '2025-09-01', NULL, NULL, 'Explosion risk'),
(4, 7, 'Admin', '2025-09-01', NULL, NULL, 'Chemical spill risk'),
(4, 8, 'Admin', '2025-09-01', NULL, NULL, 'Gas release risk'),
(5, 9, 'Admin', '2025-09-01', NULL, NULL, 'Flammable gas risk'),
(5, 10, 'Admin', '2025-09-01', NULL, NULL, 'Corrosive liquid risk'),
(6, 11, 'Admin', '2025-09-01', NULL, NULL, 'Toxic gas risk'),
(6, 12, 'Admin', '2025-09-01', NULL, NULL, 'High pressure risk'),
(7, 13, 'Admin', '2025-09-01', NULL, NULL, 'Flammable liquid risk'),
(7, 14, 'Admin', '2025-09-01', NULL, NULL, 'Chemical exposure risk'),
(8, 15, 'Admin', '2025-09-01', NULL, NULL, 'Explosion risk'),
(8, 16, 'Admin', '2025-09-01', NULL, NULL, 'High temperature risk'),
(9, 17, 'Admin', '2025-09-01', NULL, NULL, 'Corrosive gas risk'),
(9, 18, 'Admin', '2025-09-01', NULL, NULL, 'Toxic liquid risk'),
(10, 19, 'Admin', '2025-09-01', NULL, NULL, 'Flammable gas risk'),
(10, 20, 'Admin', '2025-09-01', NULL, NULL, 'High pressure risk'),
(11, 21, 'Admin', '2025-09-01', NULL, NULL, 'Chemical spill risk'),
(11, 22, 'Admin', '2025-09-01', NULL, NULL, 'Gas release risk'),
(12, 23, 'Admin', '2025-09-01', NULL, NULL, 'Flammable liquid risk'),
(12, 24, 'Admin', '2025-09-01', NULL, NULL, 'Corrosive liquid risk'),
(13, 25, 'Admin', '2025-09-01', NULL, NULL, 'Toxic gas risk');

-- 31. ReactionIntermediates (Core)
INSERT INTO ReactionIntermediates (ReactionID, Name, MolecularFormula, MolecularWeight, CASNumber, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsStable, DetectionMethod, ApprovalStatus, LastValidatedDate, Notes)
VALUES
(1, 'Ethyl Radical', 'C2H5', 29.06, '2025-62-7', 'Admin', '2025-09-01', NULL, NULL, 0, 'GC-MS', 'Approved', '2025-09-01', 'Highly reactive'),
(2, 'Carbocation A', 'C3H7+', 43.09, '19252-53-0', 'Admin', '2025-09-01', NULL, NULL, 0, 'NMR', 'Approved', '2025-09-01', 'Unstable intermediate'),
(3, 'Vinyl Radical', 'C2H3', 27.05, '3744-21-6', 'Admin', '2025-09-01', NULL, NULL, 0, 'FTIR', 'Approved', '2025-09-01', 'Reactive species'),
(4, 'Benzyl Radical', 'C7H7', 91.13, '2154-56-5', 'Admin', '2025-09-01', NULL, NULL, 0, 'GC-MS', 'Approved', '2025-09-01', 'Short-lived'),
(5, 'Peroxide Intermediate', 'ROOR', 62.07, '123-45-6', 'Admin', '2025-09-01', NULL, NULL, 0, 'HPLC', 'Approved', '2025-09-01', 'Oxidative species'),
(6, 'Carbanion A', 'C3H7-', 43.09, '1724-46-5', 'Admin', '2025-09-01', NULL, NULL, 0, 'NMR', 'Approved', '2025-09-01', 'Unstable intermediate'),
(7, 'Alkyl Radical', 'C4H9', 57.11, '3744-22-7', 'Admin', '2025-09-01', NULL, NULL, 0, 'GC-MS', 'Approved', '2025-09-01', 'Reactive species'),
(8, 'Cyclohexyl Radical', 'C6H11', 83.15, '3170-58-9', 'Admin', '2025-09-01', NULL, NULL, 0, 'FTIR', 'Approved', '2025-09-01', 'Short-lived'),
(9, 'Ester Intermediate', 'C4H8O2', 88.11, '123-45-7', 'Admin', '2025-09-01', NULL, NULL, 1, 'HPLC', 'Approved', '2025-09-01', 'Stable intermediate'),
(10, 'Hydroxyl Radical', 'OH', 17.01, '3352-57-6', 'Admin', '2025-09-01', NULL, NULL, 0, 'UV-Vis', 'Approved', '2025-09-01', 'Highly reactive'),
(11, 'Ketone Intermediate', 'C3H6O', 58.08, '67-64-1', 'Admin', '2025-09-01', NULL, NULL, 1, 'GC-MS', 'Approved', '2025-09-01', 'Stable intermediate'),
(12, 'Protonated Species', 'H3O+', 19.02, '13968-08-6', 'Admin', '2025-09-01', NULL, NULL, 0, 'NMR', 'Approved', '2025-09-01', 'Unstable intermediate'),
(13, 'Fatty Acid Radical', 'C16H31O2', 255.42, '123-45-8', 'Admin', '2025-09-01', NULL, NULL, 0, 'HPLC', 'Approved', '2025-09-01', 'Reactive species'),
(14, 'Sulfur Radical', 'S', 32.06, '7704-34-9', 'Admin', '2025-09-01', NULL, NULL, 0, 'GC-MS', 'Approved', '2025-09-01', 'Short-lived'),
(15, 'Amine Intermediate', 'C2H7N', 45.08, '75-04-7', 'Admin', '2025-09-01', NULL, NULL, 1, 'NMR', 'Approved', '2025-09-01', 'Stable intermediate'),
(16, 'Halogenated Radical', 'C2H4Cl', 62.50, '123-45-9', 'Admin', '2025-09-01', NULL, NULL, 0, 'GC-MS', 'Approved', '2025-09-01', 'Reactive species'),
(17, 'Nitro Intermediate', 'C6H5NO2', 123.11, '98-95-3', 'Admin', '2025-09-01', NULL, NULL, 1, 'HPLC', 'Approved', '2025-09-01', 'Stable intermediate'),
(18, 'Sulfonic Acid Radical', 'C6H5SO3', 141.15, '123-46-0', 'Admin', '2025-09-01', NULL, NULL, 0, 'NMR', 'Approved', '2025-09-01', 'Unstable intermediate'),
(19, 'Enzyme Intermediate', 'C6H12O6', 180.16, '50-99-7', 'Admin', '2025-09-01', NULL, NULL, 1, 'HPLC', 'Approved', '2025-09-01', 'Stable intermediate'),
(20, 'Excited State Molecule', 'C6H6*', 78.11, '71-43-2', 'Admin', '2025-09-01', NULL, NULL, 0, 'UV-Vis', 'Approved', '2025-09-01', 'Short-lived'),
(21, 'Electron Transfer Complex', 'C6H12', 84.16, '110-82-7', 'Admin', '2025-09-01', NULL, NULL, 0, 'NMR', 'Approved', '2025-09-01', 'Unstable intermediate'),
(22, 'Reduced Species', 'C2H6O', 46.07, '64-17-5', 'Admin', '2025-09-01', NULL, NULL, 1, 'GC-MS', 'Approved', '2025-09-01', 'Stable intermediate'),
(23, 'Aldehyde Intermediate', 'C3H6O', 58.08, '123-38-6', 'Admin', '2025-09-01', NULL, NULL, 1, 'HPLC', 'Approved', '2025-09-01', 'Stable intermediate'),
(24, 'Acyl Radical', 'C3H5O', 57.07, '123-46-1', 'Admin', '2025-09-01', NULL, NULL, 0, 'GC-MS', 'Approved', '2025-09-01', 'Reactive species'),
(25, 'Alcohol Intermediate', 'C2H6O', 46.07, '64-17-5', 'Admin', '2025-09-01', NULL, NULL, 1, 'NMR', 'Approved', '2025-09-01', 'Stable intermediate');

-- 32. ReactionSolvents (Bridge)
INSERT INTO ReactionSolvents (ReactionID, SolventID, Volume, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, Notes)
VALUES
(1, 1, 100.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(1, 2, 50.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(2, 3, 80.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(2, 4, 60.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(3, 5, 120.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(3, 6, 40.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(4, 7, 100.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(4, 8, 50.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(5, 9, 80.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(5, 10, 60.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(6, 11, 120.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(6, 12, 40.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(7, 13, 100.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(7, 14, 50.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(8, 15, 80.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(8, 16, 60.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(9, 17, 120.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(9, 18, 40.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(10, 19, 100.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(10, 20, 50.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(11, 21, 80.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(11, 22, 60.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(12, 23, 120.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent'),
(12, 24, 40.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Secondary solvent'),
(13, 25, 100.0, 4, 'Admin', '2025-09-01', NULL, NULL, 'Primary solvent');

-- 33. ExperimentResults (Core)
INSERT INTO ExperimentResults (ExperimentID, ResultDescription, Yield, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, ValidationStatus, ApprovalStatus, LastValidatedDate, Notes)
VALUES
(1, 'High yield of ethylene', 85.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Successful experiment'),
(2, 'Moderate yield of propylene', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(3, 'Good yield of butene', 82.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(4, 'High yield of gasoline', 90.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Optimized process'),
(5, 'Moderate yield of diesel', 78.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(6, 'Good yield of kerosene', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(7, 'High yield of aromatics', 85.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Successful experiment'),
(8, 'Moderate yield of olefins', 82.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(9, 'Good yield of polymers', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(10, 'High yield of ethanol', 85.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Optimized process'),
(11, 'Moderate yield of methanol', 78.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(12, 'Good yield of acetic acid', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(13, 'High yield of formaldehyde', 82.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Successful experiment'),
(14, 'Moderate yield of acetone', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(15, 'Good yield of benzene', 85.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(16, 'High yield of toluene', 82.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Optimized process'),
(17, 'Moderate yield of xylene', 78.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(18, 'Good yield of ethylene glycol', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(19, 'High yield of propylene glycol', 85.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Successful experiment'),
(20, 'Moderate yield of glycerol', 82.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(21, 'Good yield of butanol', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(22, 'High yield of isobutanol', 85.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Optimized process'),
(23, 'Moderate yield of pentanol', 78.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Stable results'),
(24, 'Good yield of hexanol', 80.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Consistent results'),
(25, 'High yield of heptanol', 82.0, 5, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Successful experiment');

-- 34. ProcessParameters (Core)
INSERT INTO ProcessParameters (ReactionID, ParameterName, Value, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsCritical, Tolerance, MeasurementMethod, CalibrationStatus, ApprovalStatus, LastValidatedDate, ParameterCategory, Notes)
VALUES
(1, 'Flow Rate', 100.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(1, 'Residence Time', 10.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(2, 'Flow Rate', 120.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(2, 'Residence Time', 12.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(3, 'Flow Rate', 80.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(3, 'Residence Time', 8.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(4, 'Flow Rate', 150.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(4, 'Residence Time', 15.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(5, 'Flow Rate', 90.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(5, 'Residence Time', 9.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(6, 'Flow Rate', 110.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(6, 'Residence Time', 11.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(7, 'Flow Rate', 100.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(7, 'Residence Time', 10.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(8, 'Flow Rate', 120.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(8, 'Residence Time', 12.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(9, 'Flow Rate', 80.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(9, 'Residence Time', 8.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(10, 'Flow Rate', 150.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(10, 'Residence Time', 15.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(11, 'Flow Rate', 90.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(11, 'Residence Time', 9.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(12, 'Flow Rate', 110.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(12, 'Residence Time', 11.0, 7, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Timer', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter'),
(13, 'Flow Rate', 100.0, 6, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Flow Meter', 'Calibrated', 'Approved', '2025-09-01', 'Process', 'Critical parameter');

-- 35. ReactionConditions (Core)
INSERT INTO ReactionConditions (ReactionID, ParameterName, Value, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsCritical, Tolerance, MeasurementMethod, CalibrationStatus, ApprovalStatus, LastValidatedDate, ParameterCategory, Notes)
VALUES
(1, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(1, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(2, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(2, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(3, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(3, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(4, 'Temperature', 450.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(4, 'Pressure', 20.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(5, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(5, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(6, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(6, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(7, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(7, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(8, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(8, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(9, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(9, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(10, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(10, 'Pressure', 15.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(11, 'Temperature', 400.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(11, 'Pressure', 5.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(12, 'Temperature', 350.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(12, 'Pressure', 10.0, 2, 'Admin', '2025-09-01', NULL, NULL, 1, 0.5, 'Pressure Gauge', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter'),
(13, 'Temperature', 300.0, 1, 'Admin', '2025-09-01', NULL, NULL, 1, 5.0, 'Thermocouple', 'Calibrated', 'Approved', '2025-09-01', 'Physical', 'Critical parameter');

-- 36. ReactionEquipment (Bridge)
INSERT INTO ReactionEquipment (ReactionID, EquipmentID, UsageDetails, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate)
VALUES
(1, 1, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL),
(1, 3, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(2, 2, 'Continuous reactor', 'Admin', '2025-09-01', NULL, NULL),
(2, 4, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(3, 5, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(3, 10, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(4, 6, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(4, 11, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(5, 7, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(5, 12, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(6, 8, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL),
(6, 13, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(7, 9, 'Continuous reactor', 'Admin', '2025-09-01', NULL, NULL),
(7, 14, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(8, 10, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(8, 15, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL),
(9, 11, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(9, 16, 'Continuous reactor', 'Admin', '2025-09-01', NULL, NULL),
(10, 12, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(10, 17, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(11, 13, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(11, 18, 'Analytical equipment', 'Admin', '2025-09-01', NULL, NULL),
(12, 14, 'Temperature control', 'Admin', '2025-09-01', NULL, NULL),
(12, 19, 'Fluid transfer', 'Admin', '2025-09-01', NULL, NULL),
(13, 15, 'Main reactor', 'Admin', '2025-09-01', NULL, NULL);

-- 37. ReactionPathways (Core)
INSERT INTO ReactionPathways (ReactionID, PathwayDescription, EnergyBarrier, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, IsPreferred, ValidationStatus, ApprovalStatus, LastValidatedDate, Notes)
VALUES
(1, 'Radical initiation pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(1, 'Alternative radical pathway', 55.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(2, 'Cationic polymerization pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(2, 'Anionic polymerization pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(3, 'Hydrogen addition pathway', 40.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(3, 'Alternative addition pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(4, 'Dehydrogenation pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(4, 'Alternative dehydrogenation pathway', 55.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(5, 'Oxidation pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(5, 'Alternative oxidation pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(6, 'Isomerization pathway', 40.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(6, 'Alternative isomerization pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(7, 'Alkylation pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(7, 'Alternative alkylation pathway', 55.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(8, 'Dehydrogenation pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(8, 'Alternative dehydrogenation pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(9, 'Esterification pathway', 40.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(9, 'Alternative esterification pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(10, 'Hydrolysis pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(10, 'Alternative hydrolysis pathway', 55.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(11, 'Condensation pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(11, 'Alternative condensation pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(12, 'Neutralization pathway', 40.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway'),
(12, 'Alternative neutralization pathway', 45.0, 'Admin', '2025-09-01', NULL, NULL, 0, 'Validated', 'Approved', '2025-09-01', 'Less favorable'),
(13, 'Saponification pathway', 50.0, 'Admin', '2025-09-01', NULL, NULL, 1, 'Validated', 'Approved', '2025-09-01', 'Preferred pathway');

-- 38. ReactionEnergyProfile (Core)
INSERT INTO ReactionEnergyProfile (ReactionID, EnergyType, Value, UnitID, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, ValidationStatus, ApprovalStatus, LastValidatedDate, Notes)
VALUES
(1, 'Activation Energy', 50.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(1, 'Reaction Enthalpy', -20.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(2, 'Activation Energy', 45.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(2, 'Reaction Enthalpy', -15.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(3, 'Activation Energy', 40.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(3, 'Reaction Enthalpy', -10.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(4, 'Activation Energy', 55.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(4, 'Reaction Enthalpy', -25.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(5, 'Activation Energy', 50.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(5, 'Reaction Enthalpy', -20.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(6, 'Activation Energy', 45.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(6, 'Reaction Enthalpy', -15.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(7, 'Activation Energy', 40.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(7, 'Reaction Enthalpy', -10.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(8, 'Activation Energy', 50.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(8, 'Reaction Enthalpy', -20.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(9, 'Activation Energy', 45.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(9, 'Reaction Enthalpy', -15.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(10, 'Activation Energy', 40.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(10, 'Reaction Enthalpy', -10.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(11, 'Activation Energy', 50.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(11, 'Reaction Enthalpy', -20.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(12, 'Activation Energy', 45.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier'),
(12, 'Reaction Enthalpy', -15.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Exothermic'),
(13, 'Activation Energy', 40.0, 8, 'Admin', '2025-09-01', NULL, NULL, 'Validated', 'Approved', '2025-09-01', 'Primary barrier');

-- 39. ExperimentLogs (Core)
INSERT INTO ExperimentLogs (ExperimentID, LogDate, LogMessage, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, LogType, Notes)
VALUES
(1, '2025-09-01', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(1, '2025-09-01', 'Pressure stabilized', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(2, '2025-09-02', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(2, '2025-09-02', 'Temperature reached setpoint', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(3, '2025-09-03', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(3, '2025-09-03', 'Flow rate adjusted', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(4, '2025-09-04', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(4, '2025-09-04', 'Catalyst added', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(5, '2025-09-05', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(5, '2025-09-05', 'Reaction completed', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(6, '2025-09-06', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(6, '2025-09-06', 'Pressure stabilized', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(7, '2025-09-07', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(7, '2025-09-07', 'Temperature reached setpoint', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(8, '2025-09-08', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(8, '2025-09-08', 'Flow rate adjusted', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(9, '2025-09-09', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(9, '2025-09-09', 'Catalyst added', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(10, '2025-09-10', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(10, '2025-09-10', 'Reaction completed', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(11, '2025-09-11', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(11, '2025-09-11', 'Pressure stabilized', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(12, '2025-09-12', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log'),
(12, '2025-09-12', 'Temperature reached setpoint', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Process update'),
(13, '2025-09-13', 'Experiment started', 'Admin', '2025-09-01', NULL, NULL, 'Info', 'Initial log');

-- 40. ReactionReferences (Core)
INSERT INTO ReactionReferences (ReactionID, ReferenceTitle, ReferenceURL, PublicationDate, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate, ReferenceType, Notes)
VALUES
(1, 'Catalytic Cracking Study', 'http://example.com/ref1', '2025-01-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(1, 'Catalytic Cracking Review', 'http://example.com/ref2', '2025-02-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(2, 'Polymerization Mechanism', 'http://example.com/ref3', '2025-03-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(2, 'Polymerization Overview', 'http://example.com/ref4', '2025-04-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(3, 'Hydrogenation Study', 'http://example.com/ref5', '2025-05-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(3, 'Hydrogenation Review', 'http://example.com/ref6', '2025-06-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(4, 'Reforming Study', 'http://example.com/ref7', '2025-07-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(4, 'Reforming Overview', 'http://example.com/ref8', '2025-08-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(5, 'Oxidation Mechanism', 'http://example.com/ref9', '2025-09-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(5, 'Oxidation Review', 'http://example.com/ref10', '2025-10-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(6, 'Isomerization Study', 'http://example.com/ref11', '2025-11-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(6, 'Isomerization Overview', 'http://example.com/ref12', '2025-12-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(7, 'Alkylation Study', 'http://example.com/ref13', '2026-01-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(7, 'Alkylation Review', 'http://example.com/ref14', '2026-02-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(8, 'Dehydrogenation Study', 'http://example.com/ref15', '2026-03-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(8, 'Dehydrogenation Overview', 'http://example.com/ref16', '2026-04-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(9, 'Esterification Study', 'http://example.com/ref17', '2026-05-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(9, 'Esterification Review', 'http://example.com/ref18', '2026-06-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(10, 'Hydrolysis Study', 'http://example.com/ref19', '2026-07-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(10, 'Hydrolysis Review', 'http://example.com/ref20', '2026-08-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(11, 'Condensation Study', 'http://example.com/ref21', '2026-09-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(11, 'Condensation Review', 'http://example.com/ref22', '2026-10-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(12, 'Neutralization Study', 'http://example.com/ref23', '2026-11-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference'),
(12, 'Neutralization Review', 'http://example.com/ref24', '2026-12-01', 'Admin', '2025-09-01', NULL, NULL, 'Review', 'Secondary reference'),
(13, 'Saponification Study', 'http://example.com/ref25', '2027-01-01', 'Admin', '2025-09-01', NULL, NULL, 'Journal', 'Primary reference');

USE ChemKineticsDB;
GO

-- Clear existing data in Units table to avoid conflicts (optional, depending on your setup)
DELETE FROM Units;
DBCC CHECKIDENT ('Units', RESEED, 0);
GO

-- 1. Units (Lookup)
INSERT INTO Units (
    UnitName, 
    Description, 
    UnitType, 
    CreatedBy, 
    CreatedDate, 
    ModifiedBy, 
    ModifiedDate, 
    IsStandard, 
    Precision, 
    MinValue, 
    MaxValue, 
    ConversionBase, 
    ApprovalStatus, 
    LastValidatedDate, 
    UnitCategory, 
    DocumentationURL, 
    UsageFrequency, 
    Notes
)
VALUES
('Celsius', 'Temperature in degrees Celsius', 'Temperature', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, -273.15, 1500.00, 'K = °C + 273.15', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/celsius', 100, 'Commonly used in refinery processes'),
('Kelvin', 'Absolute temperature scale', 'Temperature', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 2000.00, 'K = K', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/kelvin', 90, 'Standard for scientific calculations'),
('Bar', 'Pressure unit', 'Pressure', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100.00, '1 bar = 100000 Pa', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/bar', 80, 'Used in reactor pressure measurements'),
('Pascal', 'SI unit of pressure', 'Pressure', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 10000000.00, 'Pa = Pa', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/pascal', 50, 'Standard SI unit for pressure'),
('Gram', 'Unit of mass', 'Mass', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000000.00, '1 g = 0.001 kg', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/gram', 70, 'Used for small-scale measurements'),
('Kilogram', 'SI unit of mass', 'Mass', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000000.00, 'kg = kg', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/kilogram', 60, 'Used for bulk materials'),
('Liter', 'Unit of volume', 'Volume', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100000.00, '1 L = 0.001 m³', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/liter', 85, 'Common for liquid measurements'),
('Milliliter', 'Small unit of volume', 'Volume', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000.00, '1 mL = 0.001 L', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/milliliter', 65, 'Used in analytical chemistry'),
('Percent', 'Percentage for yield', 'Yield', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100.00, '% = %', 'Approved', '2025-09-04', 'Performance', 'http://example.com/docs/percent', 95, 'Used for reaction yields'),
('Mole', 'Amount of substance', 'Amount', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000000.00, 'mol = mol', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/mole', 75, 'Standard for chemical reactions'),
('Millimole', 'Small unit of substance amount', 'Amount', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000.00, '1 mmol = 0.001 mol', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/millimole', 60, 'Used in lab-scale reactions'),
('Liter per Minute', 'Flow rate unit', 'Flow Rate', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 10000.00, '1 L/min = 0.00001667 m³/s', 'Approved', '2025-09-04', 'Process', 'http://example.com/docs/literperminute', 70, 'Used in reactor flow control'),
('Cubic Meter per Hour', 'Large-scale flow rate', 'Flow Rate', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100000.00, 'm³/h = m³/h', 'Approved', '2025-09-04', 'Process', 'http://example.com/docs/cubicmeterperhour', 55, 'Used in industrial processes'),
('Second', 'Unit of time', 'Time', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 3600.00, 's = s', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/second', 80, 'Used for reaction timing'),
('Minute', 'Unit of time', 'Time', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1440.00, '1 min = 60 s', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/minute', 65, 'Used for process durations'),
('Kilojoule per Mole', 'Energy per mole', 'Energy', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, -10000.00, 10000.00, 'kJ/mol = kJ/mol', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/kilojoulepermole', 90, 'Used for activation energy'),
('Joule per Mole', 'Small energy per mole', 'Energy', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, -10000000.00, 10000000.00, '1 J/mol = 0.001 kJ/mol', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/joulepermole', 50, 'Used in energy profiles'),
('Gram per Liter', 'Mass concentration', 'Concentration', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000.00, 'g/L = g/L', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/gramperliter', 70, 'Used for solution concentrations'),
('Mole per Liter', 'Molar concentration', 'Concentration', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100.00, 'mol/L = mol/L', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/moleperliter', 85, 'Standard for reaction kinetics'),
('Atmosphere', 'Pressure unit', 'Pressure', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100.00, '1 atm = 101325 Pa', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/atmosphere', 60, 'Used in gas-phase reactions'),
('Millibar', 'Small pressure unit', 'Pressure', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 10000.00, '1 mbar = 100 Pa', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/millibar', 50, 'Used in low-pressure systems'),
('Ton', 'Large unit of mass', 'Mass', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 100000.00, '1 t = 1000 kg', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/ton', 40, 'Used for industrial-scale materials'),
('Cubic Meter', 'Large unit of volume', 'Volume', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 1000000.00, 'm³ = m³', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/cubicmeter', 45, 'Used in large reactors'),
('Hour', 'Long unit of time', 'Time', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, 0.00, 8760.00, '1 h = 3600 s', 'Approved', '2025-09-04', 'Physical', 'http://example.com/docs/hour', 55, 'Used for extended processes'),
('Calorie per Mole', 'Energy per mole', 'Energy', 'Admin', '2025-09-04', NULL, NULL, 1, 0.01, -1000000.00, 1000000.00, '1 cal/mol = 4.184 J/mol', 'Approved', '2025-09-04', 'Chemical', 'http://example.com/docs/caloriepermole', 50, 'Used in thermodynamic studies');



SELECT ReactionID, ReactionName, Description
FROM Reactions
WHERE ReactionName LIKE '%Cracking%';

USE ChemKineticsDB;
GO

-- 1. AuditLog
SELECT * FROM AuditLog;

--2. Catalyst_Supplier
SELECT * FROM Catalyst_Supplier;

-- 3. Catalysts
SELECT * FROM Catalysts;

--4. ChemicalProperties
SELECT* FROM ChemicalProperties;

--5. DataSources
SELECT* FROM DataSources;

--6. Equipment
SELECT* FROM Equipment;

--7. ErrorLog
SELECT* FROM ErrorLog;

--8. Experiment_Catalyst
SELECT* FROM Experiment_Catalyst;

--


