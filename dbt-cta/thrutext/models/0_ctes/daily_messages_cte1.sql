{{ config(
    cluster_by = "loaded_at",
    partition_by = {"field": "loaded_at", "data_type": "timestamp", "granularity": "day"}
) }}

select
   {{ dbt_utils.surrogate_key([
    'message_id',
    'conversation_id',
    'campaign_id',
    'contact_id'
    ]) }} as _daily_messages_hashid,
    * -- use * in case custom fields get added
from {{ source('cta', '_raw_daily_messages') }}
