{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('all_campaign_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'title',
        'due_by',
        'timezone',
        'created_at',
        'creator_id',
        'intro_html',
        boolean_to_string('is_started'),
        'updated_at',
        'description',
        boolean_to_string('is_approved'),
        boolean_to_string('is_archived'),
        boolean_to_string('is_template'),
        'primary_color',
        'autosend_limit',
        'logo_image_url',
        'autosend_status',
        'organization_id',
        'autosend_user_id',
        'texting_hours_end',
        'external_system_id',
        boolean_to_string('landlines_filtered'),
        'texting_hours_start',
        boolean_to_string('is_autoassign_enabled'),
        'messaging_service_sid',
        boolean_to_string('use_dynamic_assignment'),
        boolean_to_string('limit_assignment_to_teams'),
        'replies_stale_after_minutes',
        'autosend_limit_max_contact_id',
    ]) }} as _airbyte_all_campaign_hashid,
    tmp.*
from {{ ref('all_campaign_ab2') }} tmp
-- all_campaign
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

