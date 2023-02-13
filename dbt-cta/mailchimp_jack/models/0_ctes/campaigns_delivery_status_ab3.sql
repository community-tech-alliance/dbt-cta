{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_delivery_status_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'status',
        boolean_to_string('enabled'),
        boolean_to_string('can_cancel'),
        'emails_sent',
        'emails_canceled',
    ]) }} as _airbyte_delivery_status_hashid,
    tmp.*
from {{ ref('campaigns_delivery_status_ab2') }} tmp
-- delivery_status at campaigns/delivery_status
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

