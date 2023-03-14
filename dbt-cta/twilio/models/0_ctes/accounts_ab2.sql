{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('accounts_ab1') }}
select
    cast(sid as {{ dbt_utils.type_string() }}) as sid,
    cast(uri as {{ dbt_utils.type_string() }}) as uri,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(auth_token as {{ dbt_utils.type_string() }}) as auth_token,
    cast({{ empty_string_to_null('date_created') }} as {{ type_timestamp_with_timezone() }}) as date_created,
    cast({{ empty_string_to_null('date_updated') }} as {{ type_timestamp_with_timezone() }}) as date_updated,
    cast(friendly_name as {{ dbt_utils.type_string() }}) as friendly_name,
    cast(subresource_uris as {{ type_json() }}) as subresource_uris,
    cast(owner_account_sid as {{ dbt_utils.type_string() }}) as owner_account_sid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('accounts_ab1') }}
-- accounts
where 1 = 1

