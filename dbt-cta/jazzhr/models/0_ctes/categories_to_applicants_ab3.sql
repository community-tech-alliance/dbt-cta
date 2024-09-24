{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('categories_to_applicants_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'category_id',
        'applicant_id',
        'id',
    ]) }} as _airbyte_categories_to_applicants_hashid,
    tmp.*
from {{ ref('categories_to_applicants_ab2') }} as tmp
-- categories_to_applicants
where 1 = 1
