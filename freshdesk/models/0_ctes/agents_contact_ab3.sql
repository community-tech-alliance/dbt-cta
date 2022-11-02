{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('agents_contact_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_agents_hashid',
        'name',
        'email',
        'phone',
        boolean_to_string('active'),
        'mobile',
        'language',
        'job_title',
        'time_zone',
        'created_at',
        'updated_at',
        'last_login_at',
    ]) }} as _airbyte_contact_hashid,
    tmp.*
from {{ ref('agents_contact_ab2') }} tmp
-- contact at agents/contact
where 1 = 1

