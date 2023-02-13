{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_ab_split_opts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'subject_a',
        'subject_b',
        'wait_time',
        'split_size',
        'split_test',
        'wait_units',
        'from_name_a',
        'from_name_b',
        'pick_winner',
        'send_time_a',
        'send_time_b',
        'reply_email_a',
        'reply_email_b',
        'send_time_winner',
    ]) }} as _airbyte_ab_split_opts_hashid,
    tmp.*
from {{ ref('campaigns_ab_split_opts_ab2') }} tmp
-- ab_split_opts at campaigns/ab_split_opts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

