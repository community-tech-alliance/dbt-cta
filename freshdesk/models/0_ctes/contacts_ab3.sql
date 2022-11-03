{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contacts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'name',
        'email',
        'phone',
        boolean_to_string('active'),
        'mobile',
        'address',
        'language',
        'job_title',
        'time_zone',
        'company_id',
        'created_at',
        'twitter_id',
        'updated_at',
        'csat_rating',
        'description',
        'facebook_id',
        object_to_string('custom_fields'),
        'preferred_source',
        'unique_external_id',
    ]) }} as _airbyte_contacts_hashid,
    tmp.*
from {{ ref('contacts_ab2') }} tmp
-- contacts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

