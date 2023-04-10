{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "empower_partner_a",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='outreachEntries_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('outreachEntries_ab3') }}
select
    outreachCurrentCtaId,
    outreachEngagementLevel,
    outreachCreatedMts,
    outreachCtaProgress,
    outreachSnoozeType,
    outreachNote,
    outreachScheduledFollowUpMts,
    organizerEid,
    outreachDidGetResponse,
    outreachSnoozeUntilMts,
    targetEid,
    outreachContactMode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_outreachEntries_hashid
from {{ ref('outreachEntries_ab3') }}
-- outreachEntries from {{ source('empower_partner_a', '_airbyte_raw_outreachEntries') }}
where 1 = 1

