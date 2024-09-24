{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('friendly_id_slugs_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'sluggable_type',
        'scope',
        'sluggable_id',
        'created_at',
        'id',
        'slug',
    ]) }} as _airbyte_friendly_id_slugs_hashid,
    tmp.*
from {{ ref('friendly_id_slugs_ab2') }} as tmp
-- friendly_id_slugs
where 1 = 1
