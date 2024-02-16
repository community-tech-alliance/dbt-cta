{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'campaign_insights') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    campaignId,
    cast(numberOfClicks as int) as numberOfClicks,
    cast(numberOfShares as int) as numberOfShares,
    parse_json(topSharedTexts) as topSharedTexts,
    parse_json(topSharedImages) as topSharedImages,
    parse_json(topClickedImages) as topClickedImages,
    parse_json(numberOfClicksByPlatform) as numberOfClicksByPlatform,
    parse_json(numberOfSharesByPlatform) as numberOfSharesByPlatform,
    {{ dbt_utils.surrogate_key([
    'campaignId',
    'numberOfClicks',
    'numberOfShares',
    'topSharedTexts',
    'topSharedImages',
    'topClickedImages',
    'numberOfClicksByPlatform',
    'numberOfSharesByPlatform'
    ]) }} as _airbyte_campaign_insights_hashid
from {{ source('cta', 'campaign_insights') }}
