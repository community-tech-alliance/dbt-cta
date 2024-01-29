{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('petitions_signatures_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'city',
        'county',
        'extras',
        'last_name',
        'created_at',
        'address_two',
        'middle_name',
        'created_by_user_id',
        'petition_packet_id',
        'zipcode',
        'voter_match_status',
        'page_number',
        'signature_date',
        'updated_at',
        'address_one',
        'line_number',
        boolean_to_string('signature_exists'),
        'reviewer_id',
        'phone_number',
        'id',
        'state',
        'first_name',
        'email',
        'petition_page_id',
    ]) }} as _airbyte_petitions_signatures_hashid,
    tmp.*
from {{ ref('petitions_signatures_ab2') }} as tmp
-- petitions_signatures
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

