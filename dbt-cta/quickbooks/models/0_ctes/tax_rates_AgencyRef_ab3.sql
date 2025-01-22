{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tax_rates_AgencyRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_tax_rates_hashid',
        'value',
    ]) }} as _airbyte_AgencyRef_hashid,
    tmp.*
from {{ ref('tax_rates_AgencyRef_ab2') }} as tmp
-- AgencyRef at tax_rates/AgencyRef
where 1 = 1
