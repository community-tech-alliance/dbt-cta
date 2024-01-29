{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('core_fields_ocdids_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'ocdid_id',
        'core_field_id',
    ]) }} as _airbyte_core_fields_ocdids_hashid,
    tmp.*
from {{ ref('core_fields_ocdids_ab2') }} as tmp
-- core_fields_ocdids
where 1 = 1
