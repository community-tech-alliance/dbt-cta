{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bills_Line_AccountBasedExpenseLineDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_Line_hashid',
        object_to_string('TaxCodeRef'),
        'BillableStatus',
        object_to_string('AccountRef'),
        object_to_string('CustomerRef'),
    ]) }} as _airbyte_AccountBasedExpenseLineDetail_hashid,
    tmp.*
from {{ ref('bills_Line_AccountBasedExpenseLineDetail_ab2') }} as tmp
-- AccountBasedExpenseLineDetail at bills/Line/AccountBasedExpenseLineDetail
where 1 = 1
