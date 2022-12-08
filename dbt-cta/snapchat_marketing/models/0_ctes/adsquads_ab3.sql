{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('adsquads_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'end_time',
        'created_at',
        'start_time',
    ]) }} as _airbyte_adsquads_hashid,
    tmp.*
from {{ ref('adsquads_ab2') }} tmp
-- adsquads
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

