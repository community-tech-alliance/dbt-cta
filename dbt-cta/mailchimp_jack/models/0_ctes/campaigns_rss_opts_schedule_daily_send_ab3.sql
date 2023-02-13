{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_rss_opts_schedule_daily_send_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_schedule_hashid',
        boolean_to_string('friday'),
        boolean_to_string('monday'),
        boolean_to_string('sunday'),
        boolean_to_string('tuesday'),
        boolean_to_string('saturday'),
        boolean_to_string('thursday'),
        boolean_to_string('wednesday'),
    ]) }} as _airbyte_daily_send_hashid,
    tmp.*
from {{ ref('campaigns_rss_opts_schedule_daily_send_ab2') }} tmp
-- daily_send at campaigns/rss_opts/schedule/daily_send
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

