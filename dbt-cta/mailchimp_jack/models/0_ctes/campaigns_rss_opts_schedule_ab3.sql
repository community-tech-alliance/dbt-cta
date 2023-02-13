{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_rss_opts_schedule_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_rss_opts_hashid',
        'hour',
        object_to_string('daily_send'),
        'weekly_send_day',
        'monthly_send_date',
    ]) }} as _airbyte_schedule_hashid,
    tmp.*
from {{ ref('campaigns_rss_opts_schedule_ab2') }} tmp
-- schedule at campaigns/rss_opts/schedule
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

