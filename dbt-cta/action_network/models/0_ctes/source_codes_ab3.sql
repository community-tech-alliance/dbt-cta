{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('source_codes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'owner_id',
        'created_at',
        'owner_type',
        'updated_at',
        'source_code',
    ]) }} as _airbyte_source_codes_hashid,
    tmp.*
from {{ ref('source_codes_ab2') }} tmp
-- source_codes
where 1 = 1

