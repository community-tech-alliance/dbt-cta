{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tickets_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'price',
        'title',
        'total',
        'hidden',
        'available',
        'created_at',
        'updated_at',
        'description',
        'ticketed_event_id',
    ]) }} as _airbyte_tickets_hashid,
    tmp.*
from {{ ref('tickets_ab2') }} as tmp
-- tickets
where 1 = 1
