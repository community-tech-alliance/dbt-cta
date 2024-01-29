{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('tenant_quick_links_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'tenant_id',
        'updated_at',
        'created_at',
        'id',
        'quick_link_id',
    ]) }} as _airbyte_tenant_quick_links_hashid,
    tmp.*
from {{ ref('tenant_quick_links_ab2') }} as tmp
-- tenant_quick_links
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

