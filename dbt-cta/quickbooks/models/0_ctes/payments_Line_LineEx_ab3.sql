{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_Line_LineEx_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_Line_hashid',
        array_to_string(adapter.quote('any')),
    ]) }} as _airbyte_LineEx_hashid,
    tmp.*
from {{ ref('payments_Line_LineEx_ab2') }} tmp
-- LineEx at payments/Line/LineEx
where 1 = 1

