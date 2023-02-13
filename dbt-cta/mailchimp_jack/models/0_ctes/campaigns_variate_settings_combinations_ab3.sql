{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_variate_settings_combinations_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_variate_settings_hashid',
        'id',
        'reply_to',
        'from_name',
        'send_time',
        'recipients',
        'subject_line',
        'content_description',
    ]) }} as _airbyte_combinations_hashid,
    tmp.*
from {{ ref('campaigns_variate_settings_combinations_ab2') }} tmp
-- combinations at campaigns/variate_settings/combinations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

