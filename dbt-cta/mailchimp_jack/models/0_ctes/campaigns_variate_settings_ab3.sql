{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_variate_settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        array_to_string('contents'),
        'test_size',
        'wait_time',
        array_to_string('from_names'),
        array_to_string('send_times'),
        array_to_string('combinations'),
        array_to_string('subject_lines'),
        'winner_criteria',
        array_to_string('reply_to_addresses'),
        'winning_campaign_id',
        'winning_combination_id',
    ]) }} as _airbyte_variate_settings_hashid,
    tmp.*
from {{ ref('campaigns_variate_settings_ab2') }} tmp
-- variate_settings at campaigns/variate_settings
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

