{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_recipients_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_campaigns_hashid',
        'list_id',
        'list_name',
        object_to_string('segment_opts'),
        'segment_text',
        boolean_to_string('list_is_active'),
        'recipient_count',
    ]) }} as _airbyte_recipients_hashid,
    tmp.*
from {{ ref('campaigns_recipients_ab2') }} tmp
-- recipients at campaigns/recipients
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

