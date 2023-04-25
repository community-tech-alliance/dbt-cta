{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_empower_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('outreachEntries_ab1') }}
select
    cast(outreachCurrentCtaId as {{ dbt_utils.type_bigint() }}) as outreachCurrentCtaId,
    outreachEngagementLevel,
    cast(outreachCreatedMts as {{ dbt_utils.type_bigint() }}) as outreachCreatedMts,
    cast(outreachCtaProgress as {{ dbt_utils.type_string() }}) as outreachCtaProgress,
    cast(outreachSnoozeType as {{ dbt_utils.type_string() }}) as outreachSnoozeType,
    cast(outreachNote as {{ dbt_utils.type_string() }}) as outreachNote,
    outreachScheduledFollowUpMts,
    cast(organizerEid as {{ dbt_utils.type_string() }}) as organizerEid,
    {{ cast_to_boolean('outreachDidGetResponse') }} as outreachDidGetResponse,
    cast(outreachSnoozeUntilMts as {{ dbt_utils.type_bigint() }}) as outreachSnoozeUntilMts,
    cast(targetEid as {{ dbt_utils.type_string() }}) as targetEid,
    cast(outreachContactMode as {{ dbt_utils.type_string() }}) as outreachContactMode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('outreachEntries_ab1') }}
-- outreachEntries
where 1 = 1

