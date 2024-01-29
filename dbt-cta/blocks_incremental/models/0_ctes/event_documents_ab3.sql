{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_documents_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'event_id',
        'updated_at',
        'created_at',
        'id',
        'folder_id',
        'document_id',
    ]) }} as _airbyte_event_documents_hashid,
    tmp.*
from {{ ref('event_documents_ab2') }} as tmp
-- event_documents
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

