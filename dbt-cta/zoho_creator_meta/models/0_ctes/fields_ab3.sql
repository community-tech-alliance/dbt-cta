{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('fields_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        array_to_string('subfields'),
        boolean_to_string('unique'),
        'max_char',
        'type',
        array_to_string('choices'),
        'link_name',
        'display_name',
        boolean_to_string('mandatory'),
        'form_link_name',
        'application_link_name'
    ]) }} as _airbyte_fields_hashid,
    tmp.*
from {{ ref('fields_ab2') }} as tmp
-- fields
where 1 = 1
