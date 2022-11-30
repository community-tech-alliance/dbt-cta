{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('categories_category_data_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_categories_hashid',
        'name',
    ]) }} as _airbyte_category_data_hashid,
    tmp.*
from {{ ref('categories_category_data_ab2') }} tmp
-- category_data at categories/category_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

