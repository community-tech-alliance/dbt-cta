{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaign_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('override_organization_texting_hours'),
        'batch_size',
        'texting_hours_start',
        'logo_image_url',
        'due_by',
        'timezone',
        'created_at',
        'description',
        'texting_hours_end',
        'title',
        'primary_color',
        boolean_to_string('use_dynamic_assignment'),
        boolean_to_string('use_own_messaging_service'),
        'features',
        boolean_to_string('is_started'),
        'join_token',
        boolean_to_string('is_archived'),
        'intro_html',
        boolean_to_string('texting_hours_enforced'),
        'organization_id',
        'creator_id',
        'messageservice_sid',
        'id',
        'response_window',
    ]) }} as _airbyte_campaign_hashid,
    tmp.*
from {{ ref('campaign_ab2') }} tmp
-- campaign
where 1 = 1


