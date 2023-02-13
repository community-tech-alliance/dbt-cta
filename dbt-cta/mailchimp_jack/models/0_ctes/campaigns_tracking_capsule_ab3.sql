{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_mailchimp_jack",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('campaigns_tracking_capsule_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_tracking_hashid',
        boolean_to_string('notes'),
    ]) }} as _airbyte_capsule_hashid,
    tmp.*
from {{ ref('campaigns_tracking_capsule_ab2') }} tmp
-- capsule at campaigns/tracking/capsule
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

