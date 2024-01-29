{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('catalist_uploads_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'updated_at',
        'remote_file_url',
        'remote_id',
        'created_at',
        'id',
        'uuid',
        'status',
    ]) }} as _airbyte_catalist_uploads_hashid,
    tmp.*
from {{ ref('catalist_uploads_ab2') }} as tmp
-- catalist_uploads
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

