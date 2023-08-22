{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ocdids_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
        'ocdid_name',
        'updated_at',
        'ocdid_value',
    ]) }} as _airbyte_ocdids_hashid,
    tmp.*
from {{ ref('ocdids_ab2') }} as tmp
-- ocdids
where 1 = 1
