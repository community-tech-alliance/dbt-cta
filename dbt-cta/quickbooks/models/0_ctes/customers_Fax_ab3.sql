{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_Fax_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'FreeFormNumber',
    ]) }} as _airbyte_Fax_hashid,
    tmp.*
from {{ ref('customers_Fax_ab2') }} as tmp
-- Fax at customers/Fax
where 1 = 1
