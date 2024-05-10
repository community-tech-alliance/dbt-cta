{{ config(
    cluster_by = "timestamp",
    partition_by = {"field": "timestamp", "data_type": "timestamp", "granularity": "day"}
) }}

select
    timestamp,
    contact_id,
    contact_first_name,
    contact_last_name,
    contact_phone,
    conversation_id,
    note,
    opt_out_type,
    "Polling Location" as polling_location,
    van_campaign_id,
    van_id,
   {{ dbt_utils.surrogate_key([
    'conversation_id',
    'contact_id',
    'van_id',
    'van_campaign_id'
    ]) }} as _opt_outs_hashid
from {{ source('cta', '_stg_opt_outs') }}
