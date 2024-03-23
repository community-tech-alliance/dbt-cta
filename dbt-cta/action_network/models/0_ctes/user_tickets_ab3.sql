{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_tickets_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'amount',
        'quantity',
        'ticket_id',
        'created_at',
        'updated_at',
        'ticket_price',
        'ticket_receipt_id',
    ]) }} as _airbyte_user_tickets_hashid,
    tmp.*
from {{ ref('user_tickets_ab2') }} as tmp
-- user_tickets
where 1 = 1
