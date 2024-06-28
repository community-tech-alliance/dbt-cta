{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('government_ids_ab1') }}

select

    cast(associateOID as {{ dbt_utils.type_string() }}) as associateOID,
    cast(itemID as {{ dbt_utils.type_string() }}) as itemID,
    cast(idValue as {{ dbt_utils.type_string() }}) as idValue,
    cast(nameCode_codeValue as {{ dbt_utils.type_string() }}) as nameCode_codeValue,
    cast(nameCode_longName as {{ dbt_utils.type_string() }}) as nameCode_longName,
    cast(countryCode as {{ dbt_utils.type_string() }}) as countryCode,
    t._airbyte_raw_id,
    t._airbyte_extracted_at

from {{ ref('government_ids_ab1') }} as t
where 1 = 1
