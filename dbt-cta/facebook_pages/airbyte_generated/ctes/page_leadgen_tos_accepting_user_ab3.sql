{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_default",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('page_leadgen_tos_accepting_user_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_page_hashid',
        'birthday',
        boolean_to_string('installed'),
        'updated_time',
        array_to_string('interested_in'),
        'gender',
        'timezone',
        'link',
        'about',
        'political',
        'name_format',
        boolean_to_string('local_news_megaphone_dismiss_status'),
        'third_party_id',
        'locale',
        'quotes',
        'install_type',
        'relationship_status',
        'shared_login_upgrade_required_by',
        array_to_string('meeting_for'),
        'token_for_business',
        'id',
        'first_name',
        'email',
        'website',
        boolean_to_string('supports_donate_button_in_live_video'),
        boolean_to_string('is_guest_user'),
        boolean_to_string('verified'),
        'profile_pic',
        boolean_to_string('local_news_subscription_status'),
        'last_name',
        'middle_name',
        boolean_to_string('is_verified'),
        'religion',
        'name',
        'short_name',
    ]) }} as _airbyte_leadgen_tos_accepting_user_hashid,
    tmp.*
from {{ ref('page_leadgen_tos_accepting_user_ab2') }} tmp
-- leadgen_tos_accepting_user at page/leadgen_tos_accepting_user
where 1 = 1

