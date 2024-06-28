{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('social_insurance_programs_ab1') }}

select

    cast(associateOID as {{ dbt_utils.type_string() }}) as associateOID,
    cast(nameCode_codeValue as {{ dbt_utils.type_string() }}) as nameCode_codeValue,
    cast(nameCode_shortName as {{ dbt_utils.type_string() }}) as nameCode_shortName,
    cast(coveredIndicator as {{ dbt_utils.type_string() }}) as coveredIndicator,
    t._airbyte_raw_id,
    t._airbyte_extracted_at

from {{ ref('social_insurance_programs_ab1') }} as t
where 1 = 1
