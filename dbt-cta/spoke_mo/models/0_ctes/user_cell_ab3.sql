{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_cell_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        boolean_to_string('is_primary'),
        'user_id',
        'service',
        'id',
        'cell',
    ]) }} as _airbyte_user_cell_hashid,
    tmp.*
from {{ ref('user_cell_ab2') }} tmp
-- user_cell
where 1 = 1


