{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('core_field_timezones_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'timezone',
        'created_at',
        'updated_at',
        'core_field_id',
    ]) }} as _airbyte_core_field_timezones_hashid,
    tmp.*
from {{ ref('core_field_timezones_ab2') }} as tmp
-- core_field_timezones
where 1 = 1
