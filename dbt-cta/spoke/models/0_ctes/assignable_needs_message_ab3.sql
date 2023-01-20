{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('assignable_needs_message_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id',
        'message_status',
    ]) }} as _airbyte_assignable_needs_message_hashid,
    tmp.*
from {{ ref('assignable_needs_message_ab2') }} tmp
-- assignable_needs_message
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

