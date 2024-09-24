{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('categories_to_applicants_ab1') }}
select
    cast(category_id as {{ dbt_utils.type_string() }}) as category_id,
    cast(applicant_id as {{ dbt_utils.type_string() }}) as applicant_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    _airbyte_raw_id,
    _airbyte_extracted_at,

    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('categories_to_applicants_ab1') }}
-- categories_to_applicants
where 1 = 1
