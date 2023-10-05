{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('outgoing_caller_ids_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'account_sid',
        'date_created',
        'date_updated',
        'phone_number',
        'friendly_name',
    ]) }} as _airbyte_outgoing_caller_ids_hashid,
    tmp.*
from {{ ref('outgoing_caller_ids_ab2') }} as tmp
-- outgoing_caller_ids
where 1 = 1
