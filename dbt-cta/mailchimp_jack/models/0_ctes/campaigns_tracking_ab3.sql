{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_tracking_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        boolean_to_string('opens'),
        object_to_string('capsule'),
        boolean_to_string('ecomm360'),
        'clicktale',
        object_to_string('salesforce'),
        boolean_to_string('html_clicks'),
        boolean_to_string('text_clicks'),
        boolean_to_string('goal_tracking'),
        'google_analytics',
    ]) }} as _airbyte_tracking_hashid,
    tmp.*
from {{ ref('campaigns_tracking_ab2') }} tmp
-- tracking at campaigns/tracking
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

