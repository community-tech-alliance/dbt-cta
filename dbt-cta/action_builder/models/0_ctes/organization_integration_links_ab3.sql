{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organization_integration_links_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'settings',
        'parent_id',
        'created_at',
        'updated_at',
        'linkable_id',
        'linkable_type',
        'external_entity_id',
        'external_entity_type',
        'organization_integration_id',
    ]) }} as _airbyte_organization_integration_links_hashid,
    tmp.*
from {{ ref('organization_integration_links_ab2') }} tmp
-- organization_integration_links
where 1 = 1

