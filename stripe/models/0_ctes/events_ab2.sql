{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(data as {{ type_json() }}) as data,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    request,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(api_version as {{ dbt_utils.type_string() }}) as api_version,
    cast(pending_webhooks as {{ dbt_utils.type_bigint() }}) as pending_webhooks,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_ab1') }}
-- events
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

