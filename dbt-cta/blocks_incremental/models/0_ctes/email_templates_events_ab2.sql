{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('email_templates_events_ab1') }}
select
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(email_template_id as {{ dbt_utils.type_bigint() }}) as email_template_id,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('email_templates_events_ab1') }}
-- email_templates_events
where 1 = 1
