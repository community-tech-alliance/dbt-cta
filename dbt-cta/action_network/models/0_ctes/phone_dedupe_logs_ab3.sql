{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('phone_dedupe_logs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'phone',
        'owner_id',
        'source_id',
        'created_at',
        'owner_type',
        'updated_at',
        'source_type',
        'kept_core_field_id',
        'removed_core_field_id',
    ]) }} as _airbyte_phone_dedupe_logs_hashid,
    tmp.*
from {{ ref('phone_dedupe_logs_ab2') }} tmp
-- phone_dedupe_logs
where 1 = 1

