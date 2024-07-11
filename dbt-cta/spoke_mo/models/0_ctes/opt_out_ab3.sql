{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('opt_out_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'reason_code',
        'assignment_id',
        'organization_id',
        'created_at',
        'id',
        'cell',
    ]) }} as _airbyte_opt_out_hashid,
    tmp.*
from {{ ref('opt_out_ab2') }} tmp
-- opt_out
where 1 = 1


