select
    _airbyte_bill_payments_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_VendorRef_hashid
from {{ source('cta','bill_payments_VendorRef_base') }}
