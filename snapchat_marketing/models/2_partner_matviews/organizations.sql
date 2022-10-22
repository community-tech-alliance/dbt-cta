{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'airbyte_organizations_hashid'
) }}

SELECT
     _airbyte_organizations_hashid
    ,MAX(id) as id
    ,MAX(name) as name
    ,MAX(type) as type
    ,MAX(ARRAY_TO_STRING(roles,',')) as roles
    ,MAX(state) as state
    ,MAX(country) as country
    ,MAX(locality) as locality
    ,MAX(created_at) as created_at
    ,MAX(updated_at) as updated_at
    ,MAX(postal_code) as postal_code
    ,MAX(contact_name) as contact_name
    ,MAX(my_member_id) as my_member_id
    ,MAX(contact_email) as contact_email
    ,MAX(contact_phone) as contact_phone
    ,MAX(address_line_1) as address_line_1
    ,MAX(createdByCaller) as createdByCaller
    ,MAX(my_display_name) as my_display_name
    ,MAX(my_invited_email) as my_invited_email
    ,MAX(contact_phone_optin) as contact_phone_optin
    ,MAX(accepted_term_version) as accepted_term_version
    ,MAX(configuration_settings) as configuration_settings
    ,MAX(administrative_district_level_1) as administrative_district_level_1
    ,MAX(_airbyte_ab_id) as _airbyte_ab_id
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
    ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'organizations_base') }}
GROUP BY _airbyte_organizations_hashid
