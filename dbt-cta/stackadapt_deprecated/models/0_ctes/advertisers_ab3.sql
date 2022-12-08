{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_vfp_stackadapt_raw",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('advertisers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'description',
        'external_access',
        array_to_string('all_line_item_ids'),
        'external_access_code',
    ]) }} as _airbyte_advertisers_hashid,
    tmp.*
from {{ ref('advertisers_ab2') }} tmp
-- advertisers
where 1 = 1

