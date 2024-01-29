{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('taxes_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'id',
        'type',
        'version',
        object_to_string('tax_data'),
        boolean_to_string('is_deleted'),
        'updated_at',
        array_to_string('absent_at_location_ids'),
        boolean_to_string('present_at_all_locations'),
    ]) }} as _airbyte_taxes_hashid,
    tmp.*
from {{ ref('taxes_ab2') }} as tmp
-- taxes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

