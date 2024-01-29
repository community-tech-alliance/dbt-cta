{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('signatures_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'text',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_signatures_hashid,
    tmp.*
from {{ ref('signatures_ab2') }} as tmp
-- signatures
where 1 = 1
