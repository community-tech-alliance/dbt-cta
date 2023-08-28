{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('applications_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'application_name',
        'date_format',
        'creation_date',
        'category',
        'link_name',
        'time_zone',
        'created_by',
        'workspace_name',
    ]) }} as _airbyte_applications_hashid,
    tmp.*
from {{ ref('applications_ab2') }} as tmp
-- applications
where 1 = 1
