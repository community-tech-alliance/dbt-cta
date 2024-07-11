{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organization_contact_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'carrier',
        'last_lookup',
        'lookup_name',
        'status_code',
        'subscribe_status',
        'service',
        'organization_id',
        'created_at',
        'id',
        'contact_number',
        'user_number',
        'last_error_code',
    ]) }} as _airbyte_organization_contact_hashid,
    tmp.*
from {{ ref('organization_contact_ab2') }} tmp
-- organization_contact
where 1 = 1


