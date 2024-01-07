{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('import_lcv_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'citizen',
        'date_delivered',
        'address',
        'gender',
        'city',
        'signature',
        'last_name',
        'middle_name',
        'ssn',
        'zipcode',
        'signature_date',
        'dob',
        'organizer',
        'restored',
        'location',
        'phone_number',
        'region',
        'felony',
        'first_name',
        'email',
    ]) }} as _airbyte_import_lcv_hashid,
    tmp.*
from {{ ref('import_lcv_ab2') }} as tmp
-- import_lcv
where 1 = 1
