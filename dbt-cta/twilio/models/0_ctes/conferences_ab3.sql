{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('conferences_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sid',
        'uri',
        'region',
        'status',
        'account_sid',
        'api_version',
        'date_created',
        'date_updated',
        'friendly_name',
        object_to_string('subresource_uris'),
        'reason_conference_ended',
        'call_sid_ending_conference',
    ]) }} as _airbyte_conferences_hashid,
    tmp.*
from {{ ref('conferences_ab2') }} tmp
-- conferences
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

