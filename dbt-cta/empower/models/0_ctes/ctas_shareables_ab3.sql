{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('ctas_shareables_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_ctas_hashid',
        'displayLabel',
        'type',
        'url',
    ]) }} as _airbyte_shareables_hashid,
    tmp.*
from {{ ref('ctas_shareables_ab2') }} tmp
-- shareables at ctas/shareables
where 1 = 1

