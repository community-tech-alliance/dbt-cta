{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_campaigns_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'hidden',
        'group_id',
        'created_at',
        'updated_at',
    ]) }} as _airbyte_email_campaigns_hashid,
    tmp.*
from {{ ref('email_campaigns_ab2') }} as tmp
-- email_campaigns
where 1 = 1
