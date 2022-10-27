{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_source_redirect_ab1') }}
select
    _airbyte_source_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(return_url as {{ dbt_utils.type_string() }}) as return_url,
    cast(failure_reason as {{ dbt_utils.type_string() }}) as failure_reason,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_redirect_ab1') }}
-- redirect at charges/source/redirect
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

