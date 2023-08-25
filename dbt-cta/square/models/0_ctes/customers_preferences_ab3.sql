{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_preferences_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        boolean_to_string('email_unsubscribed'),
    ]) }} as _airbyte_preferences_hashid,
    tmp.*
from {{ ref('customers_preferences_ab2') }} as tmp
-- preferences at customers/preferences
where 1 = 1
