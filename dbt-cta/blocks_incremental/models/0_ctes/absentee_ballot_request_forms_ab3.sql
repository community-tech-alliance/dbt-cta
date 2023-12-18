{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('absentee_ballot_request_forms_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'gender',
        boolean_to_string('eligible_voting_age'),
        'batch_id',
        'name_suffix',
        'date_of_birth',
        'extras',
        'last_name',
        'created_at',
        'middle_name',
        'created_by_user_id',
        boolean_to_string('us_citizen'),
        'residential_address_id',
        'email_address',
        'updated_at',
        'shift_id',
        'election_id',
        'request_date',
        'phone_number',
        'id',
        'first_name',
        'ballot_delivery_address_id',
    ]) }} as _airbyte_absentee_ballot_request_forms_hashid,
    tmp.*
from {{ ref('absentee_ballot_request_forms_ab2') }} tmp
-- absentee_ballot_request_forms
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

