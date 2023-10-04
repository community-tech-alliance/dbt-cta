{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('pages_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'application_link_name',
        'link_name',
        'display_name',
    ]) }} as _airbyte_pages_hashid,
    tmp.*
from {{ ref('pages_ab2') }} as tmp
-- pages
where 1 = 1
