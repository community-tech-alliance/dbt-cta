{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_freshdesk_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        array_to_string('portal_languages'),
        'primary_language',
        array_to_string('supported_languages'),
    ]) }} as _airbyte_settings_hashid,
    tmp.*
from {{ ref('settings_ab2') }} tmp
-- settings
where 1 = 1

