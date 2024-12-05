{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('account_campaigns_stats_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date',
        'channel',
        'end_date',
        'line_item',
        'start_date',
        'campaign_id',
        'campaign_type',
    ]) }} as _airbyte_account_campaigns_stats_hashid,
    tmp.*
from {{ ref('account_campaigns_stats_ab2') }} as tmp
-- account_campaigns_stats
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}

