{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_documents_phone_banking_phone_banks_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('documents_phone_banking_phone_banks_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('documents_phone_banking_phone_banks_ab2') }}
