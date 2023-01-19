{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('taggable_logbook_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(tag_id as {{ dbt_utils.type_bigint() }}) as tag_id,
    {{ cast_to_boolean('available') }} as available,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(created_by as {{ dbt_utils.type_bigint() }}) as created_by,
    cast({{ empty_string_to_null('deleted_at') }} as {{ type_timestamp_without_timezone() }}) as deleted_at,
    cast(deleted_by as {{ dbt_utils.type_bigint() }}) as deleted_by,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(campaign_id as {{ dbt_utils.type_bigint() }}) as campaign_id,
    cast(interact_id as {{ dbt_utils.type_string() }}) as interact_id,
    cast(taggable_id as {{ dbt_utils.type_bigint() }}) as taggable_id,
    cast(signature_id as {{ dbt_utils.type_bigint() }}) as signature_id,
    cast(taggable_type as {{ dbt_utils.type_string() }}) as taggable_type,
    cast(updated_by_id as {{ dbt_utils.type_bigint() }}) as updated_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('taggable_logbook_ab1') }}
-- taggable_logbook
where 1 = 1

