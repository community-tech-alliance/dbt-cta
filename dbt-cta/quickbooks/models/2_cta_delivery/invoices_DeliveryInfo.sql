select
    _airbyte_invoices_hashid,
    DeliveryType,
    _airbyte_extracted_at,
    _airbyte_DeliveryInfo_hashid
from {{ source('cta','invoices_DeliveryInfo_base') }}
