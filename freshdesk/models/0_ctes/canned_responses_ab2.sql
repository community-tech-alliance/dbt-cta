{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('canned_responses_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(content as {{ dbt_utils.type_string() }}) as content,
    cast(folder_id as {{ dbt_utils.type_bigint() }}) as folder_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    attachments,
    cast(content_html as {{ dbt_utils.type_string() }}) as content_html,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('canned_responses_ab1') }}
-- canned_responses
where 1 = 1

