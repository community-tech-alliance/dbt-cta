{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'petition_packets') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    county,
    filename,
    shift_id,
    created_at,
    updated_at,
    assignee_id,
    file_locator,
   {{ dbt_utils.surrogate_key([
     'id',
    'county',
    'filename',
    'shift_id',
    'assignee_id',
    'file_locator'
    ]) }} as _airbyte_petition_packets_hashid
from {{ source('cta', 'petition_packets') }}
