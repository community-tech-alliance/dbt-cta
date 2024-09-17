{{ config(
    cluster_by = "timestamp",
    partition_by = {"field": "timestamp", "data_type": "timestamp", "granularity": "day"}
) }}

select
   {{ dbt_utils.surrogate_key([
    'survey_id',
    'conversation_id',
    'campaign_id',
    'contact_id'
    ]) }} as _daily_surveys_hashid,
    * -- use * in case custom fields get added

from {{ source('cta', '_raw_daily_surveys') }}
