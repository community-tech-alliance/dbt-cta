{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'email_templates_events') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    event_id,
    created_at,
    updated_at,
    email_template_id,
   {{ dbt_utils.surrogate_key([
     'event_id',
    'email_template_id'
    ]) }} as _airbyte_email_templates_events_hashid
from {{ source('cta', 'email_templates_events') }}
