{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('account_native_ads_stats_creatives_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_account_native_ads_stats_hashid',
        'url',
        'size',
    ]) }} as _airbyte_creatives_hashid,
    tmp.*
from {{ ref('account_native_ads_stats_creatives_ab2') }} as tmp
-- creatives at account_native_ads_stats/creatives
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

