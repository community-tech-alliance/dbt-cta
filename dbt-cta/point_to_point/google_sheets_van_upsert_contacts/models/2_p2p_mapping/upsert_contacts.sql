select
    VanID as VanID,
    External_3ID as External_3ID,
    FirstName as FirstName,
    LastName as LastName,
    MiddleName as MiddleName,
    DOB as DOB,
    Sex as Sex,
    Address1 as Address1,
    Address2 as Address2,
    City as City,
    State as State,
    CountryCode as CountryCode,
    CellPhone as CellPhone,
    CellPhoneCountryCode as CellPhoneCountryCode,
    Email as Email
from {{ source('cta_p2p_source_base','upsert_contacts_base') }}
