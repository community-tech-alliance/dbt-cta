
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'delivery_forms_exclusions') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   delivery_id,
   voter_registration_scan_id,
   {{ dbt_utils.surrogate_key([
     'delivery_id',
    'voter_registration_scan_id'
    ]) }} as _airbyte_delivery_forms_exclusions_hashid
from {{ source('cta', 'delivery_forms_exclusions') }}