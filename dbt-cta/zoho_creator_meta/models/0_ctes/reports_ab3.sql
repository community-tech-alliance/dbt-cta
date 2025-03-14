{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('reports_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'application_link_name',
        'type',
        'link_name',
        'display_name',
    ]) }} as _airbyte_reports_hashid,
    tmp.*
from {{ ref('reports_ab2') }} as tmp
-- reports
where 1 = 1
