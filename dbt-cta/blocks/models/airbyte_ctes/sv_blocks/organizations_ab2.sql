{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('organizations_ab1') }}
select
    cast(street_address as {{ dbt_utils.type_string() }}) as street_address,
    cast(notes as {{ dbt_utils.type_string() }}) as notes,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(extras as {{ dbt_utils.type_string() }}) as extras,
    cast({{ empty_string_to_null('created_at') }} as {{ type_timestamp_without_timezone() }}) as created_at,
    cast(denominations as {{ dbt_utils.type_string() }}) as denominations,
    cast(leader_id as {{ dbt_utils.type_bigint() }}) as leader_id,
    cast(issues as {{ dbt_utils.type_string() }}) as issues,
    cast(mailing_zipcode as {{ dbt_utils.type_string() }}) as mailing_zipcode,
    cast(soft_member_count as {{ dbt_utils.type_bigint() }}) as soft_member_count,
    cast({{ empty_string_to_null('updated_at') }} as {{ type_timestamp_without_timezone() }}) as updated_at,
    cast(turf_id as {{ dbt_utils.type_bigint() }}) as turf_id,
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(state as {{ dbt_utils.type_string() }}) as state,
    cast(membership_type_legacy as {{ dbt_utils.type_bigint() }}) as membership_type_legacy,
    cast(slug as {{ dbt_utils.type_string() }}) as slug,
    cast(membership_type as {{ dbt_utils.type_string() }}) as membership_type,
    cast(mailing_city as {{ dbt_utils.type_string() }}) as mailing_city,
    cast(website as {{ dbt_utils.type_string() }}) as website,
    cast(contact_name as {{ dbt_utils.type_string() }}) as contact_name,
    cast(mailing_state as {{ dbt_utils.type_string() }}) as mailing_state,
    cast(address_id as {{ dbt_utils.type_bigint() }}) as address_id,
    {{ cast_to_boolean('active') }} as active,
    cast(created_by_user_id as {{ dbt_utils.type_bigint() }}) as created_by_user_id,
    cast(zipcode as {{ dbt_utils.type_string() }}) as zipcode,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(organization_type as {{ dbt_utils.type_bigint() }}) as organization_type,
    cast(phone_number as {{ dbt_utils.type_string() }}) as phone_number,
    cast(members_count as {{ dbt_utils.type_bigint() }}) as members_count,
    cast(influence_level as {{ dbt_utils.type_bigint() }}) as influence_level,
    cast(mailing_street_address as {{ dbt_utils.type_string() }}) as mailing_street_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_ab1') }}
-- organizations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

