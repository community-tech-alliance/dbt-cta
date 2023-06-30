{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('search_documents_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        'created_at',
        'id',
        'document_id',
        'search_id'
    ]) }} as _airbyte_search_documents_hashid,
    tmp.*
from {{ ref('search_documents_ab2') }} tmp
-- search_documents
where 1 = 1

