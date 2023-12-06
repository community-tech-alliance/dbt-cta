{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_default",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('post_ab1') }}
select
    cast(sharedposts as {{ type_json() }}) as sharedposts,
    cast({{ empty_string_to_null('created_time') }} as {{ type_timestamp_with_timezone() }}) as created_time,
    cast(sponsor_tags as {{ type_json() }}) as sponsor_tags,
    cast(comments as {{ type_json() }}) as comments,
    message_tags,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(reactions as {{ type_json() }}) as reactions,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast({{ adapter.quote('to') }} as {{ type_json() }}) as {{ adapter.quote('to') }},
    cast(message as {{ dbt_utils.type_string() }}) as message,
    cast(permalink_url as {{ dbt_utils.type_string() }}) as permalink_url,
    actions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('post_ab1') }}
-- post
where 1 = 1

