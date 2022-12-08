{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"}
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('organizations_configuration_settings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_organizations_hashid',
        boolean_to_string('notifications_enabled'),
    ]) }} as _airbyte_configuration_settings_hashid,
    tmp.*
from {{ ref('organizations_configuration_settings_ab2') }} tmp
-- configuration_settings at organizations/configuration_settings
where 1 = 1

