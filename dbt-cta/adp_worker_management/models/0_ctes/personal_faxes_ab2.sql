{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('personal_faxes_ab1') }}

SELECT
	cast(associateOID as {{ dbt_utils.type_string() }}) as associateOID,
	cast(itemID as {{ dbt_utils.type_string() }}) as itemID,
	cast(nameCode_codeValue as {{ dbt_utils.type_string() }}) as nameCode_codeValue,
	cast(nameCode_shortName as {{ dbt_utils.type_string() }}) as nameCode_shortName,
	cast(countryDialing as {{ dbt_utils.type_string() }}) as countryDialing,
	cast(areaDialing as {{ dbt_utils.type_string() }}) as areaDialing,
	cast(dialNumber as {{ dbt_utils.type_string() }}) as dialNumber,
	cast(access as {{ dbt_utils.type_string() }}) as access,
	cast(formattedNumber as {{ dbt_utils.type_string() }}) as formattedNumber,
	t._airbyte_ab_id,
    t._airbyte_emitted_at

from {{ ref('personal_faxes_ab1') }} as t
where 1 = 1