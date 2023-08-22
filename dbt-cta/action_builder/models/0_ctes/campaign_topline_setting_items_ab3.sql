{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_topline_setting_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'item_id',
        boolean_to_string('imported'),
        'position',
        'item_type',
        'created_at',
        'updated_at',
        'campaign_id',
        'targetable_id',
        'targetable_type',
    ]) }} as _airbyte_campaign_topline_setting_items_hashid,
    tmp.*
from {{ ref('campaign_topline_setting_items_ab2') }} as tmp
-- campaign_topline_setting_items
where 1 = 1
