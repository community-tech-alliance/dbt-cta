{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ad_sets_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'end_time',
        'account_id',
        'start_time',
        'campaign_id',
        'created_time',
    ]) }} as _airbyte_ad_sets_hashid,
    tmp.*
from {{ ref('ad_sets_ab2') }} tmp
-- ad_sets
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

