{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('outreachEntries_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'outreachCurrentCtaId',
        'outreachEngagementLevel',
        'outreachCreatedMts',
        'outreachCtaProgress',
        'outreachSnoozeType',
        'outreachNote',
        'outreachScheduledFollowUpMts',
        'organizerEid',
        boolean_to_string('outreachDidGetResponse'),
        'outreachSnoozeUntilMts',
        'targetEid',
        'outreachContactMode',
    ]) }} as _airbyte_outreachEntries_hashid,
    tmp.*
from {{ ref('outreachEntries_ab2') }} tmp
-- outreachEntries
where 1 = 1

