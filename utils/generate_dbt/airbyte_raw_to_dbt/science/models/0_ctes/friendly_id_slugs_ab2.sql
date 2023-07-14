
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('friendly_id_slugs_ab1') }}

select
    cast(sluggable_type as {{ dbt_utils.type_string() }}) as sluggable_type,
    cast(sluggable_id as {{ dbt_utils.type_bigint() }}) as sluggable_id,
    cast(scope as {{ dbt_utils.type_string() }}) as scope,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at
from {{ ref('friendly_id_slugs_ab1') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}