{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('email_fields_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'text',
        'title',
        'email_id',
        'created_at',
        'field_type',
        'updated_at',
        'builder_html',
        'builder_json',
    ]) }} as _airbyte_email_fields_hashid,
    tmp.*
from {{ ref('email_fields_ab2') }} as tmp
-- email_fields
where 1 = 1
