{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_Line_DiscountLineDetail_DiscountAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_DiscountLineDetail_hashid',
        'name',
        'value',
    ]) }} as _airbyte_DiscountAccountRef_hashid,
    tmp.*
from {{ ref('invoices_Line_DiscountLineDetail_DiscountAccountRef_ab2') }} as tmp
-- DiscountAccountRef at invoices/Line/DiscountLineDetail/DiscountAccountRef
where 1 = 1
