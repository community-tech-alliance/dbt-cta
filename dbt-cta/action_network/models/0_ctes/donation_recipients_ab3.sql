{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('donation_recipients_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'group_id',
        'created_at',
        'updated_at',
        'fundraising_id',
    ]) }} as _airbyte_donation_recipients_hashid,
    tmp.*
from {{ ref('donation_recipients_ab2') }} as tmp
-- donation_recipients
where 1 = 1
