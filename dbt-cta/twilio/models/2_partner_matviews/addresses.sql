select
    sid,
    uri,
    city,
    region,
    street,
    verified,
    validated,
    account_sid,
    iso_country,
    postal_code,
    date_created,
    date_updated,
    customer_name,
    friendly_name,
    street_secondary,
    emergency_enabled,
from {{ source('cta','addresses_base') }}