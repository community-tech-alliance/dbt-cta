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
    "Polling Location" as polling_location, -- This field needs to be renamed or dbt/BQ throws an error
    * except (`Polling Location`) -- use * in case custom fields get added

from {{ source('cta', '_stg_daily_surveys') }}
