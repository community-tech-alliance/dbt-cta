{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('person_api_lookups_export_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'person_lookup_id',
        'created_at',
        'exported_at',
        'api_match_id',
        'api_username',
        'person_lookup_type',
        'updated_at',
        'api_key',
        'api_type',
        boolean_to_string('success'),
        'van_database_mode',
        'id',
        'campaign_id',
    ]) }} as _airbyte_person_api_lookups_export_hashid,
    tmp.*
from {{ ref('person_api_lookups_export_ab2') }} tmp
-- person_api_lookups_export
where 1 = 1

