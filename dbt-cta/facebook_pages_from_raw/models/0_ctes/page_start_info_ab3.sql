{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_start_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_page_hashid',
        'date',
        'type',
    ]) }} as _airbyte_start_info_hashid,
    tmp.*
from {{ ref('page_start_info_ab2') }} tmp
-- start_info at page/start_info
where 1 = 1

