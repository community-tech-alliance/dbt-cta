{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('estimates_Line_SalesItemLineDetail_TaxCodeRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_SalesItemLineDetail_hashid',
        'value',
    ]) }} as _airbyte_TaxCodeRef_hashid,
    tmp.*
from {{ ref('estimates_Line_SalesItemLineDetail_TaxCodeRef_ab2') }} tmp
-- TaxCodeRef at estimates/Line/SalesItemLineDetail/TaxCodeRef
where 1 = 1

