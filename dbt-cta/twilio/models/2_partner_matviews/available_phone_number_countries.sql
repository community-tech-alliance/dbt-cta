select
    uri,
    beta,
    country,
    country_code,
    subresource_uris,
from {{ source('cta','available_phone_number_countries_base') }}