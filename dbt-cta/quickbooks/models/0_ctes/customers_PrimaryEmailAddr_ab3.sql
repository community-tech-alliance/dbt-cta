{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_PrimaryEmailAddr_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'Address',
    ]) }} as _airbyte_PrimaryEmailAddr_hashid,
    tmp.*
from {{ ref('customers_PrimaryEmailAddr_ab2') }} as tmp
-- PrimaryEmailAddr at customers/PrimaryEmailAddr
where 1 = 1
