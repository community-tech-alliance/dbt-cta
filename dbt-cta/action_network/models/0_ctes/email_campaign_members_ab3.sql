{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_campaign_members_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'email_id',
        'created_at',
        'updated_at',
        'email_campaign_id',
    ]) }} as _airbyte_email_campaign_members_hashid,
    tmp.*
from {{ ref('email_campaign_members_ab2') }} tmp
-- email_campaign_members
where 1 = 1

