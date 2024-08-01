{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('regions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'organizationId',
        'inviteCodeCreatedMts',
        'ctaId',
        'inviteCode',
        'name',
        'description',
        'id',
    ]) }} as _airbyte_regions_hashid,
    tmp.*
from {{ ref('regions_ab2') }} as tmp
-- regions
where 1 = 1
