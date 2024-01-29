{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_Line_LineEx_any_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_LineEx_hashid',
        boolean_to_string('nil'),
        boolean_to_string('typeSubstituted'),
        boolean_to_string('globalScope'),
        'scope',
        'name',
        'declaredType',
        object_to_string('value'),
    ]) }} as _airbyte_any_hashid,
    tmp.*
from {{ ref('payments_Line_LineEx_any_ab2') }} tmp
-- any at payments/Line/LineEx/any
where 1 = 1

