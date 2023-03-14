{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('calls_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('to'),
        'sid',
        'uri',
        adapter.quote('from'),
        'price',
        'status',
        'duration',
        'end_time',
        'direction',
        'group_sid',
        'trunk_sid',
        'annotation',
        'price_unit',
        'queue_time',
        'start_time',
        'account_sid',
        'answered_by',
        'api_version',
        'caller_name',
        'date_created',
        'date_updated',
        'to_formatted',
        'forwarded_from',
        'from_formatted',
        'parent_call_sid',
        'phone_number_sid',
        object_to_string('subresource_uris'),
    ]) }} as _airbyte_calls_hashid,
    tmp.*
from {{ ref('calls_ab2') }} tmp
-- calls
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

