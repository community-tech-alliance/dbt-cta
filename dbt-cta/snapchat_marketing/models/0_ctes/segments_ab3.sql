{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('segments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created_at',
        'ad_account_id',
        'organization_id',
    ]) }} as _airbyte_segments_hashid,
    tmp.*
from {{ ref('segments_ab2') }} tmp
-- segments
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

