{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'documents_phone_banking_phone_banks') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    created_at,
    updated_at,
    document_id,
    phone_bank_id,
   {{ dbt_utils.surrogate_key([
    'document_id',
    'phone_bank_id'
    ]) }} as _airbyte_documents_phone_banking_phone_banks_hashid
from {{ source('cta', 'documents_phone_banking_phone_banks') }}
