{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_government_ids_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('government_ids_ab2') }}

select
    {{ dbt_utils.surrogate_key([
        'associateOID',
        'itemID',
        'idValue',
        'nameCode_codeValue',
        'nameCode_longName',
        'countryCode',
    ]) }} as _airbyte_government_ids_hashid,
    tmp.*
from {{ ref('government_ids_ab2') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_extracted_at') }}
