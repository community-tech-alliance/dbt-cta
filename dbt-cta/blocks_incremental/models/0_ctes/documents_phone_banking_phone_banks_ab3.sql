{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('documents_phone_banking_phone_banks_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'phone_bank_id',
        'updated_at',
        'created_at',
        'document_id',
    ]) }} as _airbyte_documents_phone_banking_phone_banks_hashid,
    tmp.*
from {{ ref('documents_phone_banking_phone_banks_ab2') }} as tmp
-- documents_phone_banking_phone_banks
where 1 = 1
