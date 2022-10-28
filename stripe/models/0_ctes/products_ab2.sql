{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    {{ cast_to_boolean('active') }} as active,
    images,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(caption as {{ dbt_utils.type_string() }}) as caption,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(updated as {{ dbt_utils.type_bigint() }}) as updated,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    {{ cast_to_boolean('shippable') }} as shippable,
    attributes,
    cast(unit_label as {{ dbt_utils.type_string() }}) as unit_label,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    deactivate_on,
    cast(package_dimensions as {{ type_json() }}) as package_dimensions,
    cast(statement_descriptor as {{ dbt_utils.type_string() }}) as statement_descriptor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_ab1') }}
-- products
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

