{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('credit_memos_Line_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_credit_memos_hashid',
        'LineNum',
        'Description',
        'DetailType',
        'Amount',
        object_to_string('SalesItemLineDetail'),
        'Id',
    ]) }} as _airbyte_Line_hashid,
    tmp.*
from {{ ref('credit_memos_Line_ab2') }} as tmp
-- Line at credit_memos/Line
where 1 = 1
