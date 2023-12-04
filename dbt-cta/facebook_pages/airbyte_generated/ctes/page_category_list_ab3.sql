{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_category_list_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'api_enum',
        'name',
        'id',
    ]) }} as _airbyte_category_list_hashid,
    tmp.*
from {{ ref('page_category_list_ab2') }} tmp
-- category_list at page/category_list
where 1 = 1

