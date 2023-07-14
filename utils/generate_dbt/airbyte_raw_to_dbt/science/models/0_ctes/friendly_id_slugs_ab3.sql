
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
) }}

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('friendly_id_slugs_ab2') }}

select
    
    {{ dbt_utils.surrogate_key([
        'sluggable_type',
        'sluggable_id',
        'scope',
        'created_at',
        'id',
        'slug'
    ]) }} as _airbyte_friendly_id_slugs_hashid,
    tmp.*
    
from {{ ref('friendly_id_slugs_ab2') }} as tmp
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}