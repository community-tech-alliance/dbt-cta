{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_business_pagers_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('business_pagers_ab2') }}

select
    {{ dbt_utils.surrogate_key([
        'associateOID',
        'itemID',
        'nameCode_codeValue',
        'nameCode_shortName',
        'countryDialing',
        'areaDialing',
        'dialNumber',
        'access',
        'formattedNumber',
    ]) }} as _airbyte_business_pagers_hashid,
    tmp.*
from {{ ref('business_pagers_ab2') }} tmp

where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

