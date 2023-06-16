{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('quick_links_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'bg_color',
        'size',
        'updated_at',
        'icon',
        'link',
        'created_at',
        'id',
        'label',
        'text_color',
        'block_id',
        'target',
    ]) }} as _airbyte_quick_links_hashid,
    tmp.*
from {{ ref('quick_links_ab2') }} tmp
-- quick_links
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

