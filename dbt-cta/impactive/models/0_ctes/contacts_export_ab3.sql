{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('contacts_export_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        boolean_to_string('reported_requested_vbm'),
        'selected_voterbase_id',
        'city',
        boolean_to_string('can_vbm_online'),
        'voter_last_name',
        'created_at',
        boolean_to_string('automatic_vbm'),
        'zip_code',
        'van_id',
        'contact_type',
        'unit_number',
        'updated_at',
        boolean_to_string('can_vbm'),
        'id',
        'mail_address',
        boolean_to_string('reported_registered'),
        'first_name',
        'requested_absentee_form',
        'email',
        'campaign_id',
        'mail_zip_code',
        'requested_registration_form',
        'voter_first_name',
        'address',
        boolean_to_string('invited'),
        'last_name',
        'mail_city',
        'assigned_user_id',
        'exported_at',
        boolean_to_string('reg_confirmed'),
        'full_name',
        'pdi_id',
        'state_abbrev',
        'outvote_user_id',
        'mail_state_abbrev',
        'phone',
        boolean_to_string('can_register_online'),
        boolean_to_string('vbm_confirmed'),
        'dwid_id',
        'taggings',
        'mail_unit_number',
        'customizations',
        boolean_to_string('needs_attention'),
        'reg_state',
        'vbm_state',
    ]) }} as _airbyte_contacts_export_hashid,
    tmp.*
from {{ ref('contacts_export_ab2') }} tmp
-- contacts_export
where 1 = 1

