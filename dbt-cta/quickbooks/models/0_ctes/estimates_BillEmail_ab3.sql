{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('estimates_BillEmail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_estimates_hashid',
        'Address',
    ]) }} as _airbyte_BillEmail_hashid,
    tmp.*
from {{ ref('estimates_BillEmail_ab2') }} as tmp
-- BillEmail at estimates/BillEmail
where 1 = 1
