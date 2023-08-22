{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contact_statuses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'created_at',
        'sort_order',
        'updated_at',
    ]) }} as _airbyte_contact_statuses_hashid,
    tmp.*
from {{ ref('contact_statuses_ab2') }} as tmp
-- contact_statuses
where 1 = 1
