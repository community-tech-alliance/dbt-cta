{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('conferences_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(region as {{ dbt_utils.type_string() }}) as region,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(account_sid as {{ dbt_utils.type_string() }}) as account_sid,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    cast(reason_conference_ended as {{ dbt_utils.type_string() }}) as reason_conference_ended,
    cast(call_sid_ending_conference as {{ dbt_utils.type_string() }}) as call_sid_ending_conference,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('conferences_ab1') }}
-- conferences
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

