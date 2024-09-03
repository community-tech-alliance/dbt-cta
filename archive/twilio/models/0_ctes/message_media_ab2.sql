{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('message_media_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(parent_sid as {{ dbt_utils.type_string() }}) as parent_sid,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(content_type as {{ dbt_utils.type_string() }}) as content_type,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('message_media_ab1') }}
-- message_media
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

