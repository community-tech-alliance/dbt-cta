{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('assignable_campaign_contacts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'campaign_id',
        'message_status',
        'contact_timezone',
        'texting_hours_end',
    ]) }} as _airbyte_assignable_campaign_contacts_hashid,
    tmp.*
from {{ ref('assignable_campaign_contacts_ab2') }} tmp
-- assignable_campaign_contacts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

