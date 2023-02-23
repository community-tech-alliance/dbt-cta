select
    uri,
    as_of,
    count,
    price,
    usage,
    category,
    end_date,
    count_unit,
    price_unit,
    start_date,
    usage_unit,
    account_sid,
    api_version,
    description,
    subresource_uris,
from {{ source('cta','usage_records_base') }}