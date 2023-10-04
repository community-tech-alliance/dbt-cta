{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_configuration_tag_categories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'position',
        'created_at',
        'updated_at',
        'campaign_id',
        'tag_category_id',
        'campaign_configuration_target_id',
        'campaign_configuration_target_type',
    ]) }} as _airbyte_campaign_configuration_tag_categories_hashid,
    tmp.*
from {{ ref('campaign_configuration_tag_categories_ab2') }} as tmp
-- campaign_configuration_tag_categories
where 1 = 1
