{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_restaurant_services_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_page_hashid',
        boolean_to_string('outdoor'),
        boolean_to_string('delivery'),
        boolean_to_string('reserve'),
        boolean_to_string('catering'),
        boolean_to_string(adapter.quote('groups')),
        boolean_to_string('pickup'),
        boolean_to_string('walkins'),
        boolean_to_string('waiter'),
        boolean_to_string('takeout'),
        boolean_to_string('kids'),
    ]) }} as _airbyte_restaurant_services_hashid,
    tmp.*
from {{ ref('page_restaurant_services_ab2') }} tmp
-- restaurant_services at page/restaurant_services
where 1 = 1

