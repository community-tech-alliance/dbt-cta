{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_recipients_segment_opts_conditions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_segment_opts_hashid',
        'op',
        'field',
        'value',
        'condition_type',
    ]) }} as _airbyte_conditions_hashid,
    tmp.*
from {{ ref('campaigns_recipients_segment_opts_conditions_ab2') }} tmp
-- conditions at campaigns/recipients/segment_opts/conditions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

