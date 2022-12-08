{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('adsquads_skadnetwork_properties_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_adsquads_hashid',
        'status',
    ]) }} as _airbyte_skadnetwork_properties_hashid,
    tmp.*
from {{ ref('adsquads_skadnetwork_properties_ab2') }} tmp
-- skadnetwork_properties at adsquads/skadnetwork_properties
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

