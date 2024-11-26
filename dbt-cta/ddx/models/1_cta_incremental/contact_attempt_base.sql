{{ config(
    partition_by = {"field": "datetime_pulled", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_cta_hash_id",
    tags = [ "contact-attempt" ],
    persist_docs = {"columns": true, "relation": true}
) }}

select
    person_id,
    state_code,
    contact_type_name,
    contact_result_name,
    phone_number,
    record_id,
    datetime_pulled,
    datetime_window_start,
    datetime_window_end,
    subscription_name,
    _cta_loaded_at,
    _cta_hash_id
from {{ ref('contact_attempt_cte2') }}
