{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('networks_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'terms',
        'created_at',
        'updated_at',
        'sms_enabled',
        'ip_pool_name',
        'csv_file_name',
        'csv_file_size',
        'csv_updated_at',
        'csv_content_type',
        'lock_custom_fields',
        'top_level_group_id',
        'opted_in_mobile_number',
    ]) }} as _airbyte_networks_hashid,
    tmp.*
from {{ ref('networks_ab2') }} as tmp
-- networks
where 1 = 1
