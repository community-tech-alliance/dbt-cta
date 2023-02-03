{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('letter_templates_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(tips as {{ dbt_utils.type_string() }}) as tips,
    cast(message as {{ dbt_utils.type_string() }}) as message,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    cast(targets as {{ dbt_utils.type_bigint() }}) as targets,
    cast(can_edit as {{ dbt_utils.type_bigint() }}) as can_edit,
    cast(editable as {{ dbt_utils.type_bigint() }}) as editable,
    cast(variants as {{ dbt_utils.type_string() }}) as variants,
    cast(letter_id as {{ dbt_utils.type_bigint() }}) as letter_id,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(image_attribution as {{ dbt_utils.type_string() }}) as image_attribution,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('letter_templates_ab1') }}
-- letter_templates
where 1 = 1

