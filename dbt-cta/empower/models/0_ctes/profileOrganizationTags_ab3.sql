{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('profileOrganizationTags_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'profileEid',
        'tagId',
    ]) }} as _airbyte_profileOrganizationTags_hashid,
    tmp.*
from {{ ref('profileOrganizationTags_ab2') }} as tmp
-- profileOrganizationTags
where 1 = 1
