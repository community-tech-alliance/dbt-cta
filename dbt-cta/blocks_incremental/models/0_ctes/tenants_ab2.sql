{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('tenants_ab1') }}
select
    cast(contact_phone as {{ dbt_utils.type_string() }}) as contact_phone,
    cast(logo_data as {{ dbt_utils.type_string() }}) as logo_data,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    leaderboard_metrics,
    cast(logo_old as {{ dbt_utils.type_string() }}) as logo_old,
    cast(contact_email as {{ dbt_utils.type_string() }}) as contact_email,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    shift_times,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(options as {{ dbt_utils.type_string() }}) as options,
    cast(subdomain as {{ dbt_utils.type_string() }}) as subdomain,
    cast(contact_last_name as {{ dbt_utils.type_string() }}) as contact_last_name,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(contact_first_name as {{ dbt_utils.type_string() }}) as contact_first_name,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('tenants_ab1') }}
-- tenants

