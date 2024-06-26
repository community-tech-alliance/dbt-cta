{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('locations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'city',
        'state',
        'status',
        'address',
        'country',
        'event_id',
        'latitude',
        'zip_code',
        'longitude',
        'created_at',
        'updated_at',
        'location_name',
        'event_campaign_id',
        'event_campaign_upload_id',
    ]) }} as _airbyte_locations_hashid,
    tmp.*
from {{ ref('locations_ab2') }} as tmp
-- locations
where 1 = 1
