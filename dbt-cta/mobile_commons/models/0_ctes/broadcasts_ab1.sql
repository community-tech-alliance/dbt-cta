{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'broadcasts') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    body,
    name,
    tags,
    status,
    campaign,
    automated,
    localtime,
    throttled,
    delivery_time,
    replies_count,
    opt_outs_count,
    excluded_groups,
    included_groups,
    include_subscribers,
    estimated_recipients_count,
   {{ dbt_utils.surrogate_key([
     'id',
    'body',
    'name',
    'status',
    'automated',
    'localtime',
    'throttled',
    'delivery_time',
    'replies_count',
    'opt_outs_count',
    'include_subscribers',
    'estimated_recipients_count'
    ]) }} as _airbyte_broadcasts_hashid
from {{ source('cta', 'broadcasts') }}
