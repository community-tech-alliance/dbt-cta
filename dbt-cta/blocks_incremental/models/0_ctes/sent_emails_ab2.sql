{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('sent_emails_ab1') }}
select
    cast(recipients_count as {{ dbt_utils.type_bigint() }}) as recipients_count,
    cast(event_id as {{ dbt_utils.type_bigint() }}) as event_id,
    cast(list_id as {{ dbt_utils.type_bigint() }}) as list_id,
    cast(email_template_id as {{ dbt_utils.type_bigint() }}) as email_template_id,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('from') }},
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(team_id as {{ dbt_utils.type_bigint() }}) as team_id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(sender_id as {{ dbt_utils.type_bigint() }}) as sender_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('sent_emails_ab1') }}
-- sent_emails
where 1 = 1
