{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'custom_conversions') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    name,
    rule,
    business,
    account_id,
    description,
    is_archived,
    data_sources,
    creation_time,
    is_unavailable,
    retention_days,
    last_fired_time,
    first_fired_time,
    custom_event_type,
    event_source_type,
    default_conversion_value,
    offline_conversion_data_set,
   {{ dbt_utils.surrogate_key([
     'id',
    'name',
    'rule',
    'business',
    'account_id',
    'description',
    'is_archived',
    'creation_time',
    'is_unavailable',
    'last_fired_time',
    'first_fired_time',
    'custom_event_type',
    'event_source_type',
    'offline_conversion_data_set'
    ]) }} as _airbyte_custom_conversions_hashid
from {{ source('cta', 'custom_conversions') }}
