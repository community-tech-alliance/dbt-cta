{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vendors_Mobile_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_vendors_hashid',
        'FreeFormNumber',
    ]) }} as _airbyte_Mobile_hashid,
    tmp.*
from {{ ref('vendors_Mobile_ab2') }} as tmp
-- Mobile at vendors/Mobile
where 1 = 1
