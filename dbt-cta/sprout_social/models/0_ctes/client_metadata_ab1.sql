{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'client_metadata') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    customer_id,
   {{ dbt_utils.surrogate_key([
     'customer_id'
    ]) }} as _airbyte_client_metadata_hashid
from {{ source('cta', 'client_metadata') }}
