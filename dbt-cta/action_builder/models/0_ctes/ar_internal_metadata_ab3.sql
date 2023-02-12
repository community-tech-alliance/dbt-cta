{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ar_internal_metadata_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'key',
        'value',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_ar_internal_metadata_hashid,
    tmp.*
from {{ ref('ar_internal_metadata_ab2') }} tmp
-- ar_internal_metadata
where 1 = 1
