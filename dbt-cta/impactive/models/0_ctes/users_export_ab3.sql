{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'num_contacts_synced',
        'selected_voterbase_id',
        'city',
        'recruited_by_id',
        'recruited_by',
        'actions_performed',
        'created_at',
        'reports_filled',
        'van_id',
        'updated_at',
        'supplied_zip_code',
        'id',
        'state',
        'first_name',
        'email',
        'campaign_id',
        'num_contacts_matched_in_district',
        'actions_completed',
        'last_name',
        'num_contacts_matched',
        'exported_at',
        'supplied_state_abbrev',
        'phone',
        'invites_sent',
        'last_active_at',
        'last_seen_at',
    ]) }} as _airbyte_users_export_hashid,
    tmp.*
from {{ ref('users_export_ab2') }} tmp
-- users_export
where 1 = 1

