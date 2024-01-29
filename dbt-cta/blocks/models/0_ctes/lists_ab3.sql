{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('lists_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'list_folder_id',
        'query',
        'search_params',
        'created_at',
        'repopulation_status',
        'primary_emails_count',
        'people_count',
        boolean_to_string('queryable'),
        'phones_count',
        'updated_at',
        'refreshed_at',
        'user_id',
        'name',
        'id',
        'households_count',
    ]) }} as _airbyte_lists_hashid,
    tmp.*
from {{ ref('lists_ab2') }} tmp
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

