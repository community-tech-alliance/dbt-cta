{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('emails_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'email',
        'source',
        'status',
        'owner_id',
        'created_at',
        'email_type',
        'owner_type',
        'updated_at',
        'interact_id',
        'created_by_id',
        'updated_by_id',
    ]) }} as _airbyte_emails_hashid,
    tmp.*
from {{ ref('emails_ab2') }} tmp
-- emails
where 1 = 1

