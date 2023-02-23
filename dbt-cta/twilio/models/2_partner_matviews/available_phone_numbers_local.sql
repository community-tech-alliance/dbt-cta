select
    beta,
    lata,
    region,
    latitude,
    locality,
    longitude,
    iso_country,
    postal_code,
    rate_center,
    capabilities,
    capabilities_MMS,
    capabilities_SMS,
    capabilities_voice,
    phone_number,
    friendly_name,
    address_requirements,
from {{ source('cta','available_phone_numbers_local_base') }}