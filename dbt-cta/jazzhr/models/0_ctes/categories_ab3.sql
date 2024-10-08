{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('categories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'date_created',
        'name',
        'id',
        'created_by',
        'status',
    ]) }} as _airbyte_categories_hashid,
    tmp.*
from {{ ref('categories_ab2') }} as tmp
-- categories
where 1 = 1
