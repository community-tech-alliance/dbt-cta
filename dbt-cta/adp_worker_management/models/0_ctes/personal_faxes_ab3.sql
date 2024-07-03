{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_personal_faxes_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('personal_faxes_ab2') }}

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
    ]) }} as _airbyte_personal_faxes_hashid,
    tmp.*
from {{ ref('personal_faxes_ab2') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}
