select
    vanId as vanId,
    ActivistCodeID as ActivistCodeID,
    CanvassedBy as CanvassedBy,
    DateCanvassed as DateCanvassed,
    ContactTypeID as ContactTypeID,
    DisplayAsEntered as DisplayAsEntered,
    AddressLine1 as AddressLine1,
    AddressLine2 as AddressLine2,
    AddressLine3 as AddressLine3,
    CellPhone as CellPhone,
    CellPhoneCountryCode as CellPhoneCountryCode,
    City as City,
    ContactModeID as ContactModeID,
    CountryCode as CountryCode,
    DOB as DOB,
    Email as Email,
    EmployerName as EmployerName,
    AdditionalEnvelopeName as AdditionalEnvelopeName,
    FormalEnvelopeName as FormalEnvelopeName,
    EnvelopeName as EnvelopeName,
    FirstName as FirstName,
    Phone as Phone,
    PhoneCountryCode as PhoneCountryCode,
    IsInFileMatchingEnabled as IsInFileMatchingEnabled,
    LastName as LastName,
    External_3ID as External_3ID,
    MiddleName as MiddleName,
    External_81ID as External_81ID,
    OccupationName as OccupationName,
    OrganizationContactCommonName as OrganizationContactCommonName,
    OrganizationContactOfficialName as OrganizationContactOfficialName,
    OtherEmail as OtherEmail,
    Title as Title,
    ProfessionalSuffix as ProfessionalSuffix,
    AdditionalSalutation as AdditionalSalutation,
    FormalSalutation as FormalSalutation,
    Salutation as Salutation,
    SourceFileFirstName as SourceFileFirstName,
    SourceFileLastName as SourceFileLastName,
    SourceFileMiddleName as SourceFileMiddleName,
    SourceFileSuffix as SourceFileSuffix,
    SourceFileTitle as SourceFileTitle,
    StateOrProvince as StateOrProvince,
    Suffix as Suffix,
    WorkEmail as WorkEmail,
    WorkPhone as WorkPhone,
    WorkPhoneCountryCode as WorkPhoneCountryCode,
    ZipOrPostal as ZipOrPostal
from {{ source('cta_p2p_source_base','apply_activist_codes_base') }}