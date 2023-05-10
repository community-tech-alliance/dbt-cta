{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('query_results_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        array_to_string('results'),
        'query_id',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_query_results_hashid,
    tmp.*
from {{ ref('query_results_ab2') }} tmp
-- query_results
where 1 = 1

