{{ config(
    cluster_by = "timestamp",
    partition_by = {"field": "timestamp", "data_type": "timestamp", "granularity": "day"}
) }}

select
{{ dbt_utils.surrogate_key([
    'conversation_id',
    'contact_id'
    ]) }} as _opt_outs_hashid,
    * -- use * in case custom fields get added

from {{ source('cta', '_raw_opt_outs') }}
