select
    _airbyte_purchases_hashid,
    {{ adapter.quote('any') }},
    _airbyte_extracted_at,
    _airbyte_PurchaseEx_hashid
from {{ source('cta','purchases_PurchaseEx_base') }}
