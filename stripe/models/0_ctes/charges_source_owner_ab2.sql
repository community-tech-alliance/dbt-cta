{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('charges_source_owner_ab1') }}
select
    _airbyte_source_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(address as {{ type_json() }}) as address,
    cast(verified_name as {{ dbt_utils.type_string() }}) as verified_name,
    cast(verified_email as {{ dbt_utils.type_string() }}) as verified_email,
    cast(verified_phone as {{ dbt_utils.type_string() }}) as verified_phone,
    cast(verified_address as {{ dbt_utils.type_string() }}) as verified_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('charges_source_owner_ab1') }}
-- owner at charges_base/source/owner
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

