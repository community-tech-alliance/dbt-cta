{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_Line_SalesItemLineDetail_ClassRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_SalesItemLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ClassRef_hashid,
    tmp.*
from {{ ref('invoices_Line_SalesItemLineDetail_ClassRef_ab2') }} tmp
-- ClassRef at invoices/Line/SalesItemLineDetail/ClassRef
where 1 = 1

