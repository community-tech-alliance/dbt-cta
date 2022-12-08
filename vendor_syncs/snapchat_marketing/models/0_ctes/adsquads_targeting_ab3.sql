{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('adsquads_targeting_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_adsquads_hashid',
        array_to_string('geos'),
        array_to_string('demographics'),
        boolean_to_string('regulated_content'),
    ]) }} as _airbyte_targeting_hashid,
    tmp.*
from {{ ref('adsquads_targeting_ab2') }} tmp
-- targeting at adsquads/targeting
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

