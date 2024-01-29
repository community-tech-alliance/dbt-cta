{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_commerce_payouts_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_page_hashid',
        array_to_string('data'),
        object_to_string('paging'),
    ]) }} as _airbyte_commerce_payouts_hashid,
    tmp.*
from {{ ref('page_commerce_payouts_ab2') }} tmp
-- commerce_payouts at page/commerce_payouts
where 1 = 1

