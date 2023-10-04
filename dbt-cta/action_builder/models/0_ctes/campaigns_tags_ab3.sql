{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_tags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'tag_id',
        'created_at',
        'updated_at',
        'campaign_id',
    ]) }} as _airbyte_campaigns_tags_hashid,
    tmp.*
from {{ ref('campaigns_tags_ab2') }} as tmp
-- campaigns_tags
where 1 = 1
