select
    _airbyte_estimates_hashid,
    DeliveryType,
    _airbyte_extracted_at,
    _airbyte_DeliveryInfo_hashid
from {{ source('cta','estimates_DeliveryInfo_base') }}
