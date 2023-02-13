{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'title',
        'to_name',
        'reply_to',
        boolean_to_string('timewarp'),
        'folder_id',
        'from_name',
        boolean_to_string('auto_tweet'),
        boolean_to_string('inline_css'),
        boolean_to_string('auto_footer'),
        boolean_to_string('fb_comments'),
        'template_id',
        boolean_to_string('authenticate'),
        array_to_string('auto_fb_post'),
        'preview_text',
        'subject_line',
        boolean_to_string('drag_and_drop'),
        boolean_to_string('use_conversation'),
    ]) }} as _airbyte_settings_hashid,
    tmp.*
from {{ ref('campaigns_settings_ab2') }} tmp
-- settings at campaigns/settings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

