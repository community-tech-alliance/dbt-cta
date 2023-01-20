{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('link_domain_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'domain',
        'created_at',
        'updated_at',
        'cycled_out_at',
        'max_usage_count',
        'organization_id',
        'current_usage_count',
        boolean_to_string('is_manually_disabled'),
    ]) }} as _airbyte_link_domain_hashid,
    tmp.*
from {{ ref('link_domain_ab2') }} tmp
-- link_domain
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

