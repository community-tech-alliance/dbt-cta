{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_absentee_ballot_request_forms_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('absentee_ballot_request_forms_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('absentee_ballot_request_forms_ab2') }}