{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_social_insurance_programs_hashid'
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('social_insurance_programs_ab2') }}

select
    {{ dbt_utils.surrogate_key([
        'associateOID',
        'nameCode_codeValue',
        'nameCode_shortName',
        'coveredIndicator',
    ]) }} as _airbyte_social_insurance_programs_hashid,
    tmp.*
from {{ ref('social_insurance_programs_ab2') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}
