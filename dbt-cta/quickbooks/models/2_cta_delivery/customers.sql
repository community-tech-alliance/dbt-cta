select
    CurrencyRef,
    FamilyName,
    FullyQualifiedName,
    GivenName,
    CompanyName,
    ShipAddr,
    MetaData,
    PaymentMethodRef,
    BillWithParent,
    DisplayName,
    PreferredDeliveryMethod,
    ResaleNum,
    Job,
    PrimaryEmailAddr,
    WebAddr,
    BillAddr,
    PrimaryPhone,
    PrintOnCheckName,
    airbyte_cursor,
    MiddleName,
    Mobile,
    ParentRef,
    SyncToken,
    Active,
    sparse,
    domain,
    BalanceWithJobs,
    DefaultTaxCodeRef,
    Level,
    SalesTermRef,
    Id,
    Fax,
    Balance,
    Taxable,
    _airbyte_extracted_at,
    _airbyte_customers_hashid
from {{ source('cta','customers_base') }}
