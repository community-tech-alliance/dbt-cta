{{ config(
    cluster_by = "updated_at",
    partition_by = {"field": "updated_at", "data_type": "updated_at", "granularity": "day"}
) }}

select
    campaign_id,
    campaign_name,
    conversation_id,
    survey_id,
    survey_question,
    survey_type,
    response,
    contact_id,
    contact_first_name,
    contact_last_name,
    contact_phone,
    updated_at,
    sync_status,
    "Polling Location" as polling_location,
    van_campaign_id,
    van_id,
   {{ dbt_utils.surrogate_key([
    'survey_id',
    'conversation_id',
    'campaign_id',
    'contact_id',
    'van_id',
    'van_campaign_id'
    ]) }} as _daily_surveys_hashid
from {{ source('cta', '_stg_daily_surveys') }}
