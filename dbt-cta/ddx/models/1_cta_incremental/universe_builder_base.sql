{{ config(
    partition_by = {"field": "datetime_pulled", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_cta_hash_id",
    tags = [ "universe-builder" ],
    persist_docs = {"columns": true}
) }}

select
    person_id,
    state_code,
    client_slug,
    universe_name,
    subscription_name,
    _cta_loaded_at,
    _cta_hash_id
from {{ ref('universe_builder_cte2') }}
