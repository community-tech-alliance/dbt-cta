{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('catalist_syncs_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'token',
        'active',
        'client_id',
        'source_id',
        'created_at',
        'dwid_field',
        'updated_at',
        'catalist_id',
        'source_type',
        'client_secret',
        'token_expires_in',
        'token_updated_at',
    ]) }} as _airbyte_catalist_syncs_hashid,
    tmp.*
from {{ ref('catalist_syncs_ab2') }} as tmp
-- catalist_syncs
where 1 = 1
