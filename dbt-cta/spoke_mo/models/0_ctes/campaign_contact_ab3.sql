{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_contact_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'zip',
        'custom_fields',
        'timezone_offset',
        boolean_to_string('is_opted_out'),
        'last_name',
        'created_at',
        'external_id',
        'cell',
        'assignment_id',
        'message_status',
        'updated_at',
        'error_code',
        'id',
        'first_name',
        'campaign_id',
    ]) }} as _airbyte_campaign_contact_hashid,
    tmp.*
from {{ ref('campaign_contact_ab2') }} tmp
-- campaign_contact
where 1 = 1


