{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_report_summary_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'opens',
        'clicks',
        object_to_string('ecommerce'),
        'open_rate',
        'click_rate',
        'unique_opens',
        'subscriber_clicks',
    ]) }} as _airbyte_report_summary_hashid,
    tmp.*
from {{ ref('campaigns_report_summary_ab2') }} tmp
-- report_summary at campaigns/report_summary
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

