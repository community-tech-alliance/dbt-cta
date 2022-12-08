{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('conversations_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(body as {{ dbt_utils.type_string() }}) as body,
    cast(source as {{ dbt_utils.type_bigint() }}) as source,
    {{ cast_to_boolean('private') }} as private,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(category as {{ dbt_utils.type_bigint() }}) as category,
    {{ cast_to_boolean('incoming') }} as incoming,
    cast(body_text as {{ dbt_utils.type_string() }}) as body_text,
    cc_emails,
    cast(ticket_id as {{ dbt_utils.type_bigint() }}) as ticket_id,
    to_emails,
    bcc_emails,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(from_email as {{ dbt_utils.type_string() }}) as from_email,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    attachments,
    cast(support_email as {{ dbt_utils.type_string() }}) as support_email,
    cast(source_additional_info as {{ type_json() }}) as source_additional_info,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('conversations_ab1') }}
-- conversations
where 1 = 1

