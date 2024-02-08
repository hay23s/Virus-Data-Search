SET DEFINE OFF

drop table Virus1 cascade constraints;
drop table Virus2 cascade constraints;
drop table Virus3 cascade constraints;
drop table RNAVirus cascade constraints;
drop table DNAVirus cascade constraints;
drop table VaccineAgainst1 cascade constraints;
drop table VaccineAgainst2 cascade constraints;
drop table Host cascade constraints;
drop table Infects cascade constraints;
drop table Receptor cascade constraints;
drop table Targets cascade constraints;
drop table ViralDisease cascade constraints;
drop table Causes cascade constraints;
drop table Symptom cascade constraints;
drop table Has cascade constraints;
drop table Country cascade constraints;
drop table Outbreak cascade constraints;
drop table EndemicTo cascade constraints;
drop table Application cascade constraints;
drop table UsedIn cascade constraints;

CREATE TABLE Virus1 (
    Family char(30) PRIMARY KEY,
    Strandedness char(30));

INSERT INTO Virus1 VALUES('Coronaviridae','Single');
INSERT INTO Virus1 VALUES('Poxviridae','Double');
INSERT INTO Virus1 VALUES('Retroviridae','Single');
INSERT INTO Virus1 VALUES('Orthomyxoviridae','Single');
INSERT INTO Virus1 VALUES('Picornaviridae','Single');
INSERT INTO Virus1 VALUES('Secoviridae','Single');
INSERT INTO Virus1 VALUES('Herpesviridae','Double');
INSERT INTO Virus1 VALUES('Microviridae','Single');
INSERT INTO Virus1 VALUES('Filoviridae','Single');
INSERT INTO Virus1 VALUES('Paramyxoviridae','Single');
INSERT INTO Virus1 VALUES('Hepadnaviridae','Double');
INSERT INTO Virus1 VALUES('Papillomaviridae','Double');





CREATE TABLE Virus2 (
    Genus char(30) PRIMARY KEY, Family char(30),
    FOREIGN KEY (Family) REFERENCES Virus1(Family) ON DELETE CASCADE);

INSERT INTO Virus2 VALUES('Betacoronavirus','Coronaviridae');   
INSERT INTO Virus2 VALUES('Orthopoxvirus','Poxviridae');
INSERT INTO Virus2 VALUES('Lentivirus','Retroviridae');
INSERT INTO Virus2 VALUES('Alphainfluenzavirus','Orthomyxoviridae');
INSERT INTO Virus2 VALUES('Enterovirus','Picornaviridae');   
INSERT INTO Virus2 VALUES('Comovirus','Secoviridae');   
INSERT INTO Virus2 VALUES('Simplexvirus','Herpesviridae');   
INSERT INTO Virus2 VALUES('Sinsheimervirus','Microviridae');   
INSERT INTO Virus2 VALUES('Ebolavirus','Filoviridae');   
INSERT INTO Virus2 VALUES('Morbillivirus','Paramyxoviridae');   
INSERT INTO Virus2 VALUES('Orthohepadnavirus','Hepadnaviridae');   
INSERT INTO Virus2 VALUES('Chipapillomavirus','Papillomaviridae');   




CREATE TABLE Virus3 (
    virusCommonName char(30) PRIMARY KEY, Genus char(30), Status char(30), TransmissionType char(30),
    FOREIGN KEY (Genus) REFERENCES Virus2(Genus) ON DELETE CASCADE);

INSERT INTO Virus3 VALUES('SARS-CoV','Betacoronavirus','Active','Respiratory Droplets');
INSERT INTO Virus3 VALUES('Variola Virus','Orthopoxvirus','Eradicated','Airborne Particles');
INSERT INTO Virus3 VALUES('Human Immunodeficiency Virus','Lentivirus','Active','Bodily Fluids');
INSERT INTO Virus3 VALUES('Monkeypox Virus','Orthopoxvirus','Active','Direct Contact');
INSERT INTO Virus3 VALUES('Influenza A Virus','Alphainfluenzavirus','Active','Respiratory Droplets');
INSERT INTO Virus3 VALUES('Poliovirus','Enterovirus','Active','Fecal-oral');
INSERT INTO Virus3 VALUES('Vaccinia Virus','Orthopoxvirus','Active','Direct Contact');
INSERT INTO Virus3 VALUES('Cowpea Mosaic Virus','Comovirus','Active','Insects');
INSERT INTO Virus3 VALUES('Herpes Simplex Virus','Simplexvirus','Active','Bodily Fluids');
INSERT INTO Virus3 VALUES('Phi X 174','Sinsheimervirus','Active','Bacterial');
INSERT INTO Virus3 VALUES('Zaire Ebolavirus','Ebolavirus','Active','Bodily Fluids');
INSERT INTO Virus3 VALUES('Rinderpest morbillivirus','Morbillivirus','Eradicated','Direct Contact');
INSERT INTO Virus3 VALUES('Hepatitis B Virus','Orthohepadnavirus','Active','Bodily Fluids');
INSERT INTO Virus3 VALUES('Human Papillomavirus','Chipapillomavirus','Active','Direct Contact');





CREATE TABLE RNAVirus (
    virusCommonName char(30) PRIMARY KEY, Sense char(30),
    FOREIGN KEY (virusCommonName)
        REFERENCES Virus3(virusCommonName) 
        ON DELETE CASCADE); 

INSERT INTO RNAVirus VALUES('SARS-CoV','Positive');
INSERT INTO RNAVirus VALUES('Human Immunodeficiency Virus','Positive');
INSERT INTO RNAVirus VALUES('Influenza A Virus','Negative');
INSERT INTO RNAVirus VALUES('Poliovirus','Positive');
INSERT INTO RNAVirus VALUES('Cowpea Mosaic Virus','Positive');
INSERT INTO RNAVirus VALUES('Zaire Ebolavirus','Negative');
INSERT INTO RNAVirus VALUES('Rinderpest morbillivirus','Negative');



CREATE TABLE DNAVirus(
    virusCommonName char(30) PRIMARY KEY, GenomeShape char(30),
    FOREIGN KEY (virusCommonName)  
        REFERENCES Virus3(virusCommonName) 
        ON DELETE CASCADE);

INSERT INTO DNAVirus VALUES('Variola Virus','Linear');
INSERT INTO DNAVirus VALUES('Monkeypox Virus','Linear');
INSERT INTO DNAVirus VALUES('Vaccinia Virus','Linear');
INSERT INTO DNAVirus VALUES('Herpes Simplex Virus','Linear');
INSERT INTO DNAVirus VALUES('Phi X 174','Circular');
INSERT INTO DNAVirus VALUES('Hepatitis B Virus','Linear');
INSERT INTO DNAVirus VALUES('Human Papillomavirus','Circular');


CREATE TABLE VaccineAgainst1(
    Type char(30) PRIMARY KEY,
    ImmunocompromiseSafety char(30));

INSERT INTO VaccineAgainst1 VALUES('Attenuated','Unsafe');
INSERT INTO VaccineAgainst1 VALUES('Inactivated','Safe');
INSERT INTO VaccineAgainst1 VALUES('Subunit','Safe');
INSERT INTO VaccineAgainst1 VALUES('mRNA','Safe');
INSERT INTO VaccineAgainst1 VALUES('Viral Vector','Safe');

CREATE TABLE VaccineAgainst2(
    virusCommonName char(30) NOT NULL, 
    Type char(30) NOT NULL, 
    Manufacture char(35) NOT NULL, 
    Valence int, 
    DeliveryMode char(30),
    Year float,
    PRIMARY KEY(Type, virusCommonName, Manufacture),
    FOREIGN KEY(Type) REFERENCES VaccineAgainst1(Type) ON DELETE CASCADE,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE
);

INSERT INTO VaccineAgainst2 VALUES('Zaire Ebolavirus','Viral Vector','Merck & Co.',1,'Injection',2014);
INSERT INTO VaccineAgainst2 VALUES('SARS-CoV','mRNA','Pfizer',2,'Injection',2021);
INSERT INTO VaccineAgainst2 VALUES('Hepatitis B Virus','Subunit','Merck & Co.',5,'Injection',2019);
INSERT INTO VaccineAgainst2 VALUES('SARS-CoV','Inactivated','Sinovac Biotech',1,'Injection',2021);
INSERT INTO VaccineAgainst2 VALUES('Poliovirus', 'Attenuated','Cantacuzino Institute of Bucharest',1,'Oral',1961);
INSERT INTO VaccineAgainst2 VALUES('Human Papillomavirus','Subunit','Merck & Co.',9,'Injection',2014);

CREATE TABLE Host(
    hostCommonName char(30) PRIMARY KEY, 
    Type char(30));

INSERT INTO Host VALUES('Human', 'Mammal');
INSERT INTO Host VALUES('E. coli', 'Bacteria');
INSERT INTO Host VALUES('Cowpea', 'Plant');
INSERT INTO Host VALUES('Deer', 'Mammal');
INSERT INTO Host VALUES('Buffalo', 'Mammal');



CREATE TABLE Infects(
    hostCommonName char(30) NOT NULL,
    virusCommonName char(30) NOT NULL,
    PRIMARY KEY(hostCommonName, virusCommonName),
    FOREIGN KEY(hostCommonName) REFERENCES Host(hostCommonName) ON DELETE CASCADE,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE);
/*assertion needed*/

INSERT INTO Infects VALUES ('Human','SARS-CoV');
INSERT INTO Infects VALUES ('Human','Variola Virus');
INSERT INTO Infects VALUES ('Human','Human Immunodeficiency Virus');
INSERT INTO Infects VALUES ('Human','Monkeypox Virus');
INSERT INTO Infects VALUES ('Human','Influenza A Virus');
INSERT INTO Infects VALUES ('Human','Poliovirus');
INSERT INTO Infects VALUES ('Human','Vaccinia Virus');
INSERT INTO Infects VALUES ('Cowpea','Cowpea Mosaic Virus');
INSERT INTO Infects VALUES ('Human','Herpes Simplex Virus');
INSERT INTO Infects VALUES ('E. coli','Phi X 174');
INSERT INTO Infects VALUES ('Human','Zaire Ebolavirus');
INSERT INTO Infects VALUES ('Buffalo','Rinderpest morbillivirus');
INSERT INTO Infects VALUES ('Deer','Rinderpest morbillivirus');
INSERT INTO Infects VALUES ('Human','Hepatitis B Virus');
INSERT INTO Infects VALUES ('Human','Human Papillomavirus');
INSERT INTO Infects VALUES ('Cowpea','Variola Virus');
INSERT INTO Infects VALUES ('Buffalo','Variola Virus');
INSERT INTO Infects VALUES ('Deer','Variola Virus');
INSERT INTO Infects VALUES ('E. coli','Variola Virus');
INSERT INTO Infects VALUES ('Cowpea','Vaccinia Virus');
INSERT INTO Infects VALUES ('Buffalo','Vaccinia Virus');
INSERT INTO Infects VALUES ('Deer','Vaccinia Virus');
INSERT INTO Infects VALUES ('E. coli','Vaccinia Virus');



CREATE TABLE Receptor(
    receptorName char(30) PRIMARY KEY,
    CellType char(30),
    TissueType char(30));

INSERT INTO Receptor VALUES('ACE2','Enterocytes','Epithelia');
INSERT INTO Receptor VALUES('MARCO','Keratinocytes','Epidermis');
INSERT INTO Receptor VALUES('CCR5','Immune Cells','All');
INSERT INTO Receptor VALUES('GAG','Keratinocytes','Epidermis');
INSERT INTO Receptor VALUES('Sialic Acid','All','All');
INSERT INTO Receptor VALUES('CD155','Immune Cells','All');





CREATE TABLE Targets(
    receptorName char(30) NOT NULL, 
    virusCommonName char(30) NOT NULL,
    PRIMARY KEY(receptorName,virusCommonName ),
    FOREIGN KEY(receptorName) REFERENCES Receptor ON DELETE CASCADE ,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE ); 
/*assertion needed*/

INSERT INTO Targets VALUES('ACE2','SARS-CoV');
INSERT INTO Targets VALUES('MARCO','Variola Virus');
INSERT INTO Targets VALUES('CCR5','Human Immunodeficiency Virus');
INSERT INTO Targets VALUES('GAG','Monkeypox Virus');
INSERT INTO Targets VALUES('Sialic Acid','Influenza A Virus');
INSERT INTO Targets VALUES('CD155','Poliovirus');
INSERT INTO Targets VALUES('GAG','Vaccinia Virus');

CREATE TABLE ViralDisease(
    diseaseName char(30) PRIMARY KEY, 
    diseaseType char(30));


INSERT INTO ViralDisease VALUES('Smallpox','Acute');
INSERT INTO ViralDisease VALUES('AIDS','Chronic');
INSERT INTO ViralDisease VALUES('Hepatitis','Acute');
INSERT INTO ViralDisease VALUES('Herpes Labialis','Dormant');
INSERT INTO ViralDisease VALUES('Influenza','Acute');

CREATE TABLE Causes(
diseaseName char(30) NOT NULL,
virusCommonName char(30),
PRIMARY KEY (diseaseName, virusCommonName),
FOREIGN KEY(diseaseName) REFERENCES ViralDisease(diseaseName) ON DELETE CASCADE ,
FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE 
);
/*assertion needed*/

INSERT INTO Causes VALUES('Smallpox','Variola Virus');
INSERT INTO Causes VALUES('AIDS','Human Immunodeficiency Virus');
INSERT INTO Causes VALUES('Hepatitis','Hepatitis B Virus');
INSERT INTO Causes VALUES('Herpes Labialis','Herpes Simplex Virus');
INSERT INTO Causes VALUES('Influenza','Influenza A Virus');



CREATE TABLE Symptom(
 symptomName char(30) PRIMARY KEY,
 Specificity char(30));

INSERT INTO Symptom VALUES('Blisters','Non-specific');
INSERT INTO Symptom VALUES('Vomit','Non-specific');
INSERT INTO Symptom VALUES('Diarrhea','Non-specific');
INSERT INTO Symptom VALUES('Lymphadenopathy','Specific');
INSERT INTO Symptom VALUES('Macules','Specific');


CREATE TABLE Has(
    diseaseName char(30), 
    symptomName char(30), 
    Severity char(30),
    PRIMARY KEY(diseaseName, symptomName),
    FOREIGN KEY (diseaseName) REFERENCES ViralDisease(diseaseName) ,
    FOREIGN KEY(symptomName) REFERENCES Symptom(symptomName) 
);

INSERT INTO Has VALUES('Herpes Labialis','Blisters','Mild');
INSERT INTO Has VALUES('Hepatitis','Vomit','Mild');
INSERT INTO Has VALUES('Hepatitis','Diarrhea','Mild');
INSERT INTO Has VALUES('AIDS','Lymphadenopathy','Severe');
INSERT INTO Has VALUES('Smallpox','Macules','Severe');

CREATE TABLE Country(
    countryName char(30) PRIMARY KEY,
    PopulationDensity float, 
    Continent char(30), 
    Status char(30));

INSERT INTO Country VALUES('United States',36,'North America','Developed');
INSERT INTO Country VALUES('China',153,'Asia','Developing');
INSERT INTO Country VALUES('Mexico',66,'North America','Developing');
INSERT INTO Country VALUES('South Africa',25,'Africa','Developed');
INSERT INTO Country VALUES('Japan',338.2,'Asia','Developed');
INSERT INTO Country VALUES('Congo',16,'Africa','Underdeveloped');
INSERT INTO Country VALUES('Canada',4,'North America','Developed');

CREATE TABLE Outbreak(
    countryName char(30), 
    virusCommonName char(30),
    outbreakSize char(30), 
    Casualty integer, 
    Year integer, 
    Origin char(30),
    PRIMARY KEY(countryName, virusCommonName),
    FOREIGN KEY(countryName) REFERENCES Country(countryName) ON DELETE CASCADE ,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE  
);

INSERT INTO Outbreak VALUES('United States','Influenza A Virus','Pandemic',100000000,1346,'Spain');
INSERT INTO Outbreak VALUES('China','SARS-CoV','Pandemic',25000000,2019,'China');
INSERT INTO Outbreak VALUES('Mexico','Variola Virus','Epidemic',8000000,1519,'Mexico');
INSERT INTO Outbreak VALUES('Japan','Variola Virus','Epidemic',2000000,735,'Japan');
INSERT INTO Outbreak VALUES('Congo','Zaire Ebolavirus','Epidemic',55,2020,'Congo');
INSERT INTO Outbreak VALUES('China','Influenza A Virus','Pandemic',4000000,1968,'Hong Kong');
INSERT INTO Outbreak VALUES('Canada','Human Immunodeficiency Virus','Pandemic',40100000,1981,'Central Africa');


CREATE TABLE EndemicTo(
    countryName char(30), 
    virusCommonName char(30), 
    PRIMARY KEY(countryName, virusCommonName),
    FOREIGN KEY(countryName) REFERENCES Country(countryName)  ,
    FOREIGN KEY(virusCommonName) REFERENCES Virus3(virusCommonName) ON DELETE CASCADE  
);

INSERT INTO EndemicTo VALUES('United States', 'Influenza A Virus');
INSERT INTO EndemicTo VALUES('China', 'Influenza A Virus');
INSERT INTO EndemicTo VALUES('South Africa', 'Human Immunodeficiency Virus');
INSERT INTO EndemicTo VALUES('Canada', 'Hepatitis B Virus');
INSERT INTO EndemicTo VALUES('Congo', 'Human Immunodeficiency Virus');

CREATE TABLE Application(
    applicationName char(30) PRIMARY KEY, 
    Usage char(30));


INSERT INTO Application VALUES('Weapon', 'Biological Warfare');
INSERT INTO Application VALUES('Synthetic Virus', 'Research');
INSERT INTO Application VALUES('Nanotechnology', 'Research');
INSERT INTO Application VALUES('Virotherapy', 'Medicine');
INSERT INTO Application VALUES('Vaccine', 'Medicine');


CREATE TABLE UsedIn(
    applicationName char(30) NOT NULL, 
    virusCommonName char(30),
    PRIMARY KEY(applicationName, virusCommonName),
    FOREIGN KEY (applicationName) REFERENCES Application ,
    FOREIGN KEY (virusCommonName) REFERENCES Virus3 ON DELETE CASCADE
);

INSERT INTO UsedIn VALUES('Weapon', 'Vaccinia Virus');
INSERT INTO UsedIn VALUES('Synthetic Virus', 'Poliovirus');
INSERT INTO UsedIn VALUES('Nanotechnology', 'Cowpea Mosaic Virus');
INSERT INTO UsedIn VALUES('Virotherapy', 'Herpes Simplex Virus');
INSERT INTO UsedIn VALUES('Vaccine', 'Poliovirus');
