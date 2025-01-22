select
    _airbyte_customers_hashid,
    name,
    value,
    _airbyte_extracted_at,
    _airbyte_PaymentMethodRef_hashid
from {{ source('cta','customers_PaymentMethodRef_base') }}
