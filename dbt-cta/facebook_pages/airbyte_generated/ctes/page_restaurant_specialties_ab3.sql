{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_restaurant_specialties_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'lunch',
        'coffee',
        'drinks',
        'breakfast',
        'dinner',
    ]) }} as _airbyte_restaurant_specialties_hashid,
    tmp.*
from {{ ref('page_restaurant_specialties_ab2') }} tmp
-- restaurant_specialties at page/restaurant_specialties
where 1 = 1

