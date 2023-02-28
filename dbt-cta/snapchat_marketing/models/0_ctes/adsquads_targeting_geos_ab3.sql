{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('adsquads_targeting_geos_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'ad_squad_id',
        'country_code',
        'region_id',
        'metro',
        'postal_code',
        'operation'
    ]) }} as _airbyte_geos_hashid,
    tmp.*
from {{ ref('adsquads_targeting_geos_ab2') }} tmp
-- geos at adsquads/targeting/geos
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

