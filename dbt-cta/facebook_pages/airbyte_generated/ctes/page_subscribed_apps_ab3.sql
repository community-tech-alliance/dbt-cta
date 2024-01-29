{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_subscribed_apps_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_page_hashid',
        array_to_string('data'),
        object_to_string('paging'),
    ]) }} as _airbyte_subscribed_apps_hashid,
    tmp.*
from {{ ref('page_subscribed_apps_ab2') }} tmp
-- subscribed_apps at page/subscribed_apps
where 1 = 1

